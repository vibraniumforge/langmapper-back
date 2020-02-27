class Translation < ApplicationRecord
  belongs_to :language
  belongs_to :word

  # require 'mechanize'
  require 'faraday'

  require 'nokogiri'
  require 'open-uri'

  def self.all_by_macrofamily(macrofamily)
    matching_langs = Language.where(macrofamily: macrofamily)
    return_ar = []
    matching_langs.each do |lang|
      x = Translation.where(language_name: lang.name)
      x.map do |tr|
        return_ar << [tr.language_name, tr.romanization, tr.etymology]
      end
    end
    p return_ar
  end

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

    first_definition = page.css("table.translations")[0]

    first_table = first_definition.children[1].children[0].children[1].children[1].children
    second_table = first_definition.children[1].children[0].children[5].children[1].children
    puts "================================="
    puts "Word: #{chosen_word}"
    puts "Definition: #{page.css("table.translations")[0].attributes["data-gloss"].value}"

    all_li_array =[]
    first_table.each do |item|
      if item.to_s != "\n"
        all_li_array << item
      end
    end

    second_table.each do |item|
      if item.to_s != "\n"
        all_li_array << item
      end
    end

    puts "Li Count: #{all_li_array.count}"

    word_id = Word.find_or_create_by(name: chosen_word).id

    puts "Word ID: #{word_id}"

    all_li_array.each_with_index do |li, index|
      language_name = li.text.split(":")[0]

      if li.css("span.gender")[0]&.text
        gender = li.css("span.gender")[0]&.text 
      else 
        gender = nil
      end

      if li.css("span")[0]&.text && li.css("span")[0]&.text != "please add this translation if you can"
        translation = li.css("span")[0]&.text 
      else
        translation = nil
      end

      if li.css("span.tr.Latn")[0]
        romanization = li.css("span.tr.Latn")[0].children[0].text 
      else
        romanization = translation
      end

      link_eng = li.children[1].children[0].attributes["href"]&.value || "NONE"
      # "/wiki/goud#Afrikaans"
    

      # if index == 144
      #   byebug
      # end


      if link_eng != "NONE"
        full_link_eng = 'https://en.wiktionary.org' << link_eng
        puts "full_link_eng: #{full_link_eng}"
        # "https://en.wiktionary.org/wiki/goud#Afrikaans"
        if full_link_eng.ascii_only?
          etymology_page = Faraday.get(full_link_eng)
          if etymology_page.success? 
            @etymology_page_body = etymology_page.body
          else
            puts "Error"
            next
          end
        else
          next
        end
      end
      

      

      
      # if full_link_eng
      #   @escaped_full_link_eng = URI.parse(URI.escape(full_link_eng))
      # end
      # puts "@escaped_full_link_eng: #{@escaped_full_link_eng}"
      
      # if full_link_eng
      #   etymology_page = Nokogiri::HTML(open(URI.parse(URI.escape(full_link_eng))))
      
      # if full_link_eng.include?("&action=edit")
      #   etymology_page = nil
      #   etymology = nil
      # else
      #   etymology_page = Nokogiri::HTML(open(full_link_eng))
      # end
      # etymology_page = Nokogiri::HTML(open(full_link_eng))

      # end

      # if full_link_eng
      #   etymology_page = Faraday.get(full_link_eng)
      # end
      # if etymology_page.success? 
      #   @etymology_page_body = etymology_page.body
      # else
      #   puts 'error in else'
      #   break
      
      parsed_etymology_page = Nokogiri::HTML(@etymology_page_body)

      # parsed_etymology_page = Nokogiri::HTML(@escaped_full_link_eng)
      # parsed_etymology_page = Nokogiri::HTML(open(etymology_page))

      if parsed_etymology_page.css("[id^='Etymology']").length > 0
          correct_lang_parsed_etymology_page = parsed_etymology_page.css("[id^='Etymology']")[0]&.parent&.next_element
          etymology = correct_lang_parsed_etymology_page.text.strip
      else
          etymology = nil
      end

      puts "Etymology: #{etymology}"
      

      puts "#{index+1}. #{language_name} - T: #{translation ? translation : "NONE"} - R: #{romanization} - G: #{gender ? gender : "NONE"} - E: #{etymology ? etymology : "NONE"}"
      puts "\n"
      language_id = Language.find_or_create_by(name: language_name).id
      
      puts language_id
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

end
