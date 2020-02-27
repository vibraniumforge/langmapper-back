class Translation < ApplicationRecord
  belongs_to :language
  belongs_to :word

  # require 'nokogiri'
  # require 'open-uri'



  def self.scrape(chosen_word)
    t1 = Time.now
    # agent = Mechanize.new
    # con  = Faraday::Connection.new("https://en.wiktionary.org/wiki/#{chosen_word}#Translations")
    # page = con.get
    page = Nokogiri::HTML(open("https://en.wiktionary.org/wiki/#{chosen_word}#Translations"))
    # if page.success? 
    #   @page_body = page.body
    # else
    #   puts "Error"
    # end

    # @noko_page_body = Nokogiri::HTML(@page_body)

    # first_definition = page.css("table.translations")[0]
    # first_table = first_definition.children[1].children[0].children[1].children[1].children
    # second_table = first_definition.children[1].children[0].children[5].children[1].children
    # better below

    first_table1 = page.css("td.translations-cell")[0].children.children
    second_table1 = page.css("td.translations-cell")[1].children.children
    

    puts "=================================================================="
    puts "Word: #{chosen_word}"
    puts "Definition: #{page.css("table.translations")[0].attributes["data-gloss"].value}"

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
        translation = li.css("span")&.text.gsub(/\(compound\)/, "")
      else
        translation = nil
      end

      if li.css("span.tr.Latn")[0]
        romanization = li.css("span.tr.Latn")[0].children[0].text 
      else
        romanization = translation
      end

      # REFACTOR BELOW .CHILDREN ETC
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

      if etymology_page && etymology_page.css("[id^='Etymology']").length > 0
          correct_lang_parsed_etymology_page = etymology_page.css("[id^='Etymology']")[0]&.parent&.next_element
          etymology = correct_lang_parsed_etymology_page.text.strip
      else
          etymology = nil
      end

      puts "Etymology: #{etymology}"

      language_id = Language.find_or_create_by(name: language_name).id
      
      puts language_id

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

  def self.all_by_macrofamily(macrofamily)
    matching_langs = Language.where(macrofamily: macrofamily)
    return_ar = []
    matching_langs.each do |lang|
      results = Translation.where(language_name: lang.name)
      results.map do |translation|
        return_ar << [translation.language_name, translation.romanization, translation.etymology]
      end
    end
    return_ar
  end

  def self.ety_query(query)
    Translation.where("etymology LIKE :query", query: "%#{sanitize_sql_like(query)}%")
  end

end
