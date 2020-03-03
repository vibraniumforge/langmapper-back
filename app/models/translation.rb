
class Translation < ApplicationRecord
  belongs_to :language
  belongs_to :word

  require 'open-uri'

  def self.find(chosen_word)
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
    # word_id = Word.find_or_create_by("name = ?", params[:chosen_word]).id
    word_id = Word.find_or_create_by(name: chosen_word).id
    puts "Word ID: #{word_id}"

    # NEED: language_id, word_id, translation, romanization, full_link_eng, etymology, gender 

    all_li_array.each_with_index do |li, index|

      etymology = nil

      language_name = li.text.split(":")[0]

      # if ['Azerbaijani', 'Chinese'].include?(language_name)
  
      if li.css("span.gender")[0]&.text
        gender = li.css("span.gender")[0].text 
      else 
        gender = nil
      end

      # fix serbo-croat here

     

      if li.css("span")[0]&.text && li.css("span")[0]&.text != "please add this translation if you can" 
        translation = li.css("span")[0]&.text.gsub(/\(compound\)/, "")
      else
        translation = nil
      end

      # old one didnt work for serbo-croat
      # if li.css("span")[0]&.text && li.css("span")[0]&.text != "please add this translation if you can"
      #   translation = li.css("span")[0]&.text.gsub(/\(compound\)/, "")
      # else
      #   translation = nil
      # end

      if !li.css("span.tr.Latn")[0].nil?
        # romanization = li.css("span.tr.Latn")[0].children[0].text 
        romanization = li.css("span.Latn")[0].text 
      else
        romanization = translation
      end

      # if li.children[1].children[0].attributes["href"]&.value
      if !li.css("a")[0].nil? && li.css("a")[0]&.attributes["href"]&.value
        short_link_eng = li.css("a")[0]&.attributes["href"].value
      else
        short_link_eng = nil
      end
      # => "/wiki/goud#Afrikaans" || nil

      if !short_link_eng.nil?
        full_link_eng = 'https://en.wiktionary.org' << short_link_eng
        if language_name.include?("'")
          etymology_page = nil
        elsif full_link_eng.ascii_only? && !full_link_eng.include?("&action=edit")
          etymology_page = Nokogiri::HTML(open(full_link_eng))
        else
          etymology_page = nil
        end
      end
      # "https://en.wiktionary.org/wiki/goud#Afrikaans" || nil
  
      # added to method above
      # if language_name.include?("'")
      #   etymology_page = nil
      # end

      # if ['Avar', 'Coptic', 'Malagasay', 'Oroqen', 'Tatar'].include?(language_name)
      #   byebug
      # end
      
      language_name_span_id = language_name.split(" ").join("_")
      # format the name to the wiktionary style
      if !etymology_page.nil? && etymology_page.css("[id=#{language_name_span_id}]").length > 0 && etymology_page.css("[id^='Etymology']").length > 0
        # if the page exists, and the page has the language on it, and there is an etymology element
        current_element = etymology_page.css("[id=#{language_name_span_id}]")[0]&.parent.next_element
        # get the element with the id of the language_name, which is a SPAN under h2 with the lang_name. then, get the parent, the h2 tag, and then the next element. I need the current element to not be a h2, because that is my stop sign. Some pages have another h2 beneath with an ety from another lang. This is not right. This way, NULL goes in the DB, which is right, and not a wrong value.
        while !current_element.nil? && current_element.name != "h2"
          if current_element.name == "h3" && current_element.text.include?("Etymology") && !current_element.next_element.text.include?("(This etymology is missing or incomplete.")
            # usually it is a h3 with etymology, then the next p tag that has the etymology. But not always. This gets the h3 tag, and loops until it finds the p tag, THEN takes the value.
          while current_element.name != "p"
            current_element = current_element.next_element
          end
            etymology = current_element.text.strip
            break
          end
          current_element = current_element.next_element
        end
      else
        etymology = nil
      end

      language_id = Language.find_or_create_by(name: language_name).id
      puts "\n"
      puts "language_id: #{language_id}"
      puts "#{index+1}. Lang: #{language_name} - Trans: #{translation ? translation : "NONE"} - Roman: #{romanization} - Gender: #{gender ? gender : "NONE"} - Ety: #{etymology ? etymology : "NONE"}"
      puts "\n"
      puts "====================="
      Translation.create({language_id: language_id, word_id: word_id, language_name: language_name, translation: translation, romanization: romanization, link: full_link_eng, etymology: etymology, gender: gender })

    end
    t2 = Time.now
    time = t2 - t1
    puts "====================="
    puts "\nDONE \n"
    puts "Count: #{all_li_array.count}"
    puts "in #{time.round(2)} seconds"
  end

  # etymologies with a that have the query word inside.
  def self.ety_query(query)
    # Translation.where("etymology LIKE :query", query: "%#{sanitize_sql_like(params[:query])}%").pluck(:language_name, :translation, :romanization, :gender, :etymology)
    Translation.where("etymology LIKE :query", query: "%#{sanitize_sql_like(query)}%").pluck(:language_name, :translation, :romanization, :gender, :etymology)
  end

  # all the translations in a macrofamily
  def self.all_by_macrofamily(macrofamily)
    # matching_langs = Language.where("macrofamily = ?", params[:macrofamily])
    matching_langs = Language.where(macrofamily: macrofamily)
    matching_langs.map do |lang|
      lang.translations.pluck(:language_name, :romanization, :translation, :gender, :etymology)
    end
  end

  # all the translations in a specified language
  def self.all_by_lang(language)
    # language_id = Language.find_by("name = ?": params[:language]).id
    language_id = Language.find_by(name: language).id
    # arr = Translation.where("language_id = ?", params[:language_id]).pluck(:word_id, :romanization, :etymology)
    arr = Translation.where(language_id: language_id).pluck(:word_id, :romanization, :etymology)
    result = arr.map do |translation|
      [{word: Word.find(translation[0]).name}, {romanization: translation[1]}, {etymology: translation[2]}]
    end
    # pp result
    result
  end

  # genreate a hash of [{:id=>48}, {:family=>"Albanian"}, {:language=>"Albanian"}, {:romanization=>"patë"}, {:gender=>"f"}]
  def self.compare_genders(word, macrofamily="Indo-European")
    # word_id = Word.find_by("name = ?", params[:word].downcase).id)
    word_id = Word.find_by(name: word.downcase).id

    translations_array = Language.select(
      [:id, :family, :name, :romanization, :gender])
      .joins(:translations)
      .where("word_id = ? AND macrofamily = ?", word_id, macrofamily)
      .order(:family, :name)
    result = translations_array.map do |translation|
      [{id: translation.id}, {family: translation.family}, {language: translation.name}, {romanization: translation.romanization}, {gender: translation.gender}]
    end
    pp result
    result
  end

  # make a hash group by etymology
  def self.group_etys(query, macrofamily="Indo-European")
    array = []
    ety_hash = Hash.new{|k, v|}
    # word_id = Word.find_by("name = ?", params[:query].downcase).id
    # word = Word.find_by("name = ?", params[:query].downcase).name
    word_id = Word.find_by("name = ?", query.downcase).id
    word = Word.find_by("name = ?", query.downcase).name
    translations_array = Language.select([:id, :family, :name, :romanization, :etymology])
      .joins(:translations)
      .where("word_id = ? AND macrofamily = ?", word_id, macrofamily)
      .order(:etymology)
      # can I make a hash of these server side?
      # why doesnt etymology appear when look at translations_array?
    translations_array.each do |translation|
      if translation.etymology.nil?
        short_etymology = "Null"
      else
        short_etymology = translation.etymology.strip
        # short_etymology = translation.etymology.slice(0,60).strip
      end
      if ety_hash[short_etymology] 
        ety_hash[short_etymology] << translation.name
      else 
        ety_hash[short_etymology] = [translation.name]
      end
    end
    array << ety_hash 
    pp ety_hash
    # pp array
    # p array
    array
  end

end
