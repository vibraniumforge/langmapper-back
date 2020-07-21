class FindInfoService

  require 'open-uri'

  def self.find_info(chosen_word)
    t1 = Time.now
    
    query_page = Nokogiri::HTML(open("https://en.wiktionary.org/wiki/#{chosen_word}#Translations"))

    # The english language page links to all the other languages. 
    # It needs a separate case to grab its info.
    etymology_english = query_page.css("[id^='Etymology']")[0].parent.next_element.text

    # The translations table that is needed can be in 1 of 3 places.
    # 1 is on the same page.
    # 2 is /translations § Noun
    # 3 is /translations#Noun
    # If it has either of the 2 links, it is on another page.
    # There are two different formats of the link that is needed to get to that other page.
    # see which of the two link styles is used on this page

    # cant figure out why 1 & 2 dont work for "silver", "iron" etc now.
    path1 = query_page.xpath('//a[contains(text(), "/translations § Noun")]')
    path2 = query_page.xpath('//a[contains(text(), "/translations#Noun")]')
    path3 = query_page.css("#Translations")

    if path1.length > 0
      layout_path = path1[0]["href"]
    end
    if path2.length > 0
      layout_path = path2[0]["href"]
    end
    if path3.length > 0
      layout_path = path3[0].parent.next_element.children[1]["href"]
    end

    # byebug
    if layout_path.nil?
      page = Nokogiri::HTML(open(URI.parse("https://en.wiktionary.org/wiki/#{chosen_word}#Translations")))
      # page = Nokogiri::HTML(open(URI.parse("https://en.wiktionary.org/wiki/#{chosen_word}#Translations#Noun")))
      # if page.nil?
      #   page = Nokogiri::HTML(open(URI.parse("https://en.wiktionary.org/wiki/#{chosen_word}#Translations")))
      # end
    else
      page = Nokogiri::HTML(open(URI.parse("https://en.wiktionary.org#{layout_path}")))
    end

    # there are two tables full of the links we need. grab them accordingly in the all_li_array
    # byebug
    first_table1 = page.css("td.translations-cell")[0].children.children
    second_table1 = page.css("td.translations-cell")[1].children.children

    all_li_array = []
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

    # NEED TO FIND: word_id, language_id, gender, translation, romanization, full_link_eng, etymology, 

    # grab the definition from the english language page.
    # Update the Word with that info

    definition = page.css("table.translations")[0].attributes["data-gloss"].value
    word_id = Word.find_by({ word_name: chosen_word }).id
    @word = Word.find(word_id)
    @word.update({ definition: definition })

    # create the English entry first. Can't scrape this the same as other langs.
    Translation.create({ language_id: 1, word_id: word_id, translation: chosen_word, romanization: chosen_word, link: "https://en.wiktionary.org/wiki/#{chosen_word}#Translations", etymology: etymology_english, gender: nil })

    puts "=================================================================="
    puts "Word: #{chosen_word}"
    puts "Word ID: #{word_id}"
    puts "Definition: #{definition}"
    puts "Li Count: #{all_li_array.count}"

    errors_ar = []

    # This is all my current languages. Source is seeds. 
    # This exists to save a check to see if there is a matching language every time. More performant
    all_langs = Language.current_langauges_hash

    all_li_array.each_with_index do |li, index|
      etymology = nil

      # find language_id

      language_name = li.text.split(":")[0]
      language_id = all_langs.select { |lang| lang[:name] == language_name }.map { |x| x[:id] }[0]
      if language_id.nil?
        next
      end

      #  find gender

      if li.css("span.gender")[0]&.text
        gender = li.css("span.gender")[0].text
      else
        gender = nil
      end

      # find translation

      if li.css("span")[0]&.text && li.css("span")[0]&.text != "please add this translation if you can"
        translation = li.css("span")[0]&.text.gsub(/\(compound\)/, "").gsub(/\(please verify\)/, "")
        # if the translation is '(', then the setup is different. To get the first definition, use li.css("span.Latn")[0].text
        if translation == "("
          # translation = li.css("span").text.gsub(/\((♂♀)\)/, "").gsub(/\(((Föhr-Amrum))\)/, "").split("(")[0].gsub(/\W/,"")
          translation = li.css("span.Latn")[0].text
        end
        if language_name == "Serbo-Croatian"
          translation = li.css("span.Cyrl")[0]&.text
        end
        # li.css("span").text.gsub(/\((♂♀)\)/, "").split("(")[0].strip
        # li.css("span").text.gsub(/\((♂♀)\)/, "").split("(")[0].gsub(/\W/,"")
      else
        translation = nil
      end

      # find romanization

      # if !li.css("span.tr.Latn")[0].nil?
      if !li.css("span.Latn")[0]&.text.nil?
        romanization = li.css("span.Latn")[0].text
      else
        romanization = translation
      end

      # find full_link_eng

      if !li.css("a")[0].nil? && li.css("a")[0]&.attributes["href"]&.value
        short_link_eng = li.css("a")[0]&.attributes["href"].value
      else
        short_link_eng = nil
      end
      # => "/wiki/goud#Afrikaans" || nil

      if !short_link_eng.nil?
        full_link_eng = "https://en.wiktionary.org" << short_link_eng
        if language_name.include?("'") || language_name.include?("(")
          etymology_page = nil
        elsif full_link_eng.ascii_only? && !full_link_eng.include?("&action=edit")
          etymology_page = Nokogiri::HTML(open(full_link_eng))
        else
          etymology_page = nil
        end
      end
      # "https://en.wiktionary.org/wiki/goud#Afrikaans" || nil

      # find etymology

      language_name_span_id = language_name.split(" ").join("_")
      # format the name to the wiktionary style

      if !etymology_page.nil? && etymology_page.css("[id=#{language_name_span_id}]").length > 0 && etymology_page.css("[id^='Etymology']").length > 0
        # if the page exists, and the page has the language on it, and there is an etymology element
        current_element = etymology_page.css("[id=#{language_name_span_id}]")[0]&.parent.next_element
        # get the element with the id of the language_name, which is a SPAN under h2 with the language_name_span_id. Then, get the parent, the h2 tag, and then the next element.

        # I need the current element to not be a h2, because that is my stop sign. Some pages have another h2 beneath with an etymology from another lang. This is not right. This way, NULL goes in the DB, which is right, and not an incorrect value.
        while !current_element.nil? && current_element.name != "h2"
          if current_element.name == "h3" && current_element.text.include?("Etymology") && !current_element.next_element.text.include?("(This etymology is missing or incomplete.")
            # usually it is a h3 with etymology, then the next p tag that has the etymology. But not always. This gets the h3 tag, and loops until it finds the p tag, THEN takes the value.
            while !current_element.nil? && current_element.name != "p" && current_element.name != "div"
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

      # save all 7 things I need
      @translation = Translation.new({ language_id: language_id, word_id: word_id, translation: translation, romanization: romanization, link: full_link_eng, etymology: etymology, gender: gender })

      # output info to the console
      if !full_link_eng.nil? && @translation.save
        puts "\n"
        puts "language_id: #{language_id}"
        puts "#{index + 1}. Lang: #{language_name} - Trans: #{translation ? translation : "NONE"} - Roman: #{romanization} - Gender: #{gender ? gender : "NONE"} - Ety: #{etymology ? etymology : "NONE"}"
        puts "\n"
        puts "====================================================================="
        puts "\n"
      else
        puts "Translation not saved for #{language_name}"
        puts "Errors= #{@translation.errors.full_messages.join(", ")}"
        error_hash = {}
        error_hash[language_name] = @translation.errors.full_messages
        errors_ar << error_hash
      end
    end
    t2 = Time.now
    time = t2 - t1
    puts "+++++++++++++++++++++"
    puts "\nDONE with <<< #{chosen_word}, #{definition} >>> \n"
    puts "Count: #{all_li_array.count} entries"
    puts "in #{time.round(2)} seconds"
    puts "Errors: #{errors_ar}"

  end
  
end