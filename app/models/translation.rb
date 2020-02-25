class Translation < ApplicationRecord
  belongs_to :language
  belongs_to :word

  # require 'mechanize'
  # require 'faraday'
  require 'nokogiri'
  require 'open-uri'

  def self.scrape(chosen_word)
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
      gender = li.css("span.gender")[0]&.text || "NONE"
      translation = li.css("span")[0]&.text
      if li.css("span.tr.Latn")[0]
        romanization = li.css("span.tr.Latn")[0].children[0].text 
      else
        romanization = chosen_word
      end

      link_eng = li.children[1].children[0].attributes["href"]&.value || "NONE"
      # "/wiki/goud#Afrikaans"
    
      if link_eng != "NONE"
        full_link_eng = 'https://en.wiktionary.org' << link_eng
        # "https://en.wiktionary.org/wiki/goud#Afrikaans"
        if full_link_eng
          etymology_page = Faraday.get(URI.parse(URI.escape(full_link_eng)))
        end
        if etymology_page.success? 
          @etymology_page_body = etymology_page.body
        else
          break
        end
        parsed_etymology_page = Nokogiri::HTML(@etymology_page_body)
    
        if parsed_etymology_page.css("[id^='Etymology']").length > 0
          correct_lang_parsed_etymology_page = parsed_etymology_page.css("[id^='Etymology']")[0]&.parent&.next_element
          etymology = correct_lang_parsed_etymology_page.text
        else
          etymology = nil
        end
      end

      puts "#{index+1}. #{language_name} - T: #{translation ? translation : "NONE"} - R: #{romanization} - G: #{gender ? gender : "NONE"} - E: #{etymology ? etymology : "NONE"}"

      language_id = Language.find_or_create_by(name: language_name).id
      
      puts language_id
      puts "====================="
      Translation.create({language_id: language_id, word_id: word_id, translation: translation, romanization: romanization, link: full_link_eng, etymology: etymology, gender: gender })

    end

  end

end
