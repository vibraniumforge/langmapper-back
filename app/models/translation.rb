class Translation < ApplicationRecord
  belongs_to :language
  belongs_to :word

  # require 'nokogiri'
  # require 'open-uri'


  def self.scrape(chosen_word)
    t1 = Time.now
    page = Nokogiri::HTML(open("https://en.wiktionary.org/wiki/#{chosen_word}#Translations"))

    first_table1 = page.css("td.translations-cell")[0].children.children
    second_table1 = page.css("td.translations-cell")[1].children.children
    

   

    all_li_array =[]
    first_table1.each do |item|
      if item.to_s != "\n"
        all_li_array << item
      end
    end

    second_table1.each do |item|
      if item.to_s != "\n"
        all_li_array << item
      end
    end

    puts "=================================================================="
    puts "Word: #{chosen_word}"
    puts "Definition: #{page.css("table.translations")[0].attributes["data-gloss"].value}"

    puts "Li Count: #{all_li_array.count}"

    # add logic to prevent dupes here
    word_id = Word.find_or_create_by(name: chosen_word).id

    puts "Word ID: #{word_id}"

    # {language_id, word_id, language_name, translation, romanization, full_link_eng, etymology, gender }

    all_li_array.each_with_index do |li, index|
      etymology = nil
      language_name = li.text.split(":")[0]

      if li.css("span.gender")[0]&.text
        gender = li.css("span.gender")[0]&.text 
      else 
        gender = nil
      end

      if li.css("span")[0]&.text && li.css("span")[0]&.text != "please add this translation if you can"
        # should be span[0]& text
        translation = li.css("span")&.text.gsub(/\(compound\)/, "")
      else
        translation = nil
      end

      if li.css("span.tr.Latn")[0]
        romanization = li.css("span.tr.Latn")[0].children[0].text 
      else
        romanization = translation
      end

      if li.children[1].children[0].attributes["href"]&.value
        short_link_eng = li.children[1].children[0].attributes["href"]&.value
      else
        short_link_eng = nil
      end
      # => "/wiki/goud#Afrikaans"
  

      if !short_link_eng.nil?
        full_link_eng = 'https://en.wiktionary.org' << short_link_eng
        puts "full_link_eng: #{full_link_eng}"
        # "https://en.wiktionary.org/wiki/goud#Afrikaans"
        if full_link_eng.ascii_only? && !full_link_eng.include?("&action=edit")
          etymology_page = Nokogiri::HTML(open(full_link_eng))
        else
          etymology_page = nil
        end
      end

      if !etymology_page.nil? && etymology_page.css("[id^='Etymology']").length > 0
          correct_lang_parsed_etymology_page = etymology_page.css("[id^='Etymology']")[0]&.parent&.next_element
          etymology = correct_lang_parsed_etymology_page.text.strip
      else
          etymology = nil
      end

      language_id = Language.find_or_create_by(name: language_name).id
      
      puts "language_id: #{language_id}"

      puts "#{index+1}. #{language_name} - T: #{translation ? translation : "NONE"} - R: #{romanization} - G: #{gender ? gender : "NONE"} - E: #{etymology ? etymology : "NONE"}"
      puts "\n"
      puts "====================="
      Translation.create({language_id: language_id, word_id: word_id, language_name: language_name, translation: translation, romanization: romanization, link: full_link_eng, etymology: etymology, gender: gender })

    end
    t2 = Time.now
    time = t2 - t1
    puts "====================="
    puts "\n DONE \n"
    puts "Count: #{all_li_array.count}"
    puts "in #{time} seconds"
  end

  # refactor here
  def self.all_by_macrofamily(macrofamily)
    matching_langs = Language.where(macrofamily: macrofamily)
    matching_langs.map do |lang|
      lang.translations
    end
  end

  def self.ety_query(query)
    Translation.where("etymology LIKE :query", query: "%#{sanitize_sql_like(query)}%").pluck(:language_name, :translation, :gender)
  end

  def self.group_etys(query)
    array = []
    ety_hash = Hash.new{|k, v|}
    Translation.where(word_id: Word.find_by(name: query)).each do |trans|
      array << trans.etymology
      if ety_hash[trans.etymology] 
        byebug
        ety_hash[trans.etymology] << trans.language
      else 
        byebug
        ety_hash[trans.etymology] = []
      end
    end
    byebug
    array << ety_hash 
  end

end
