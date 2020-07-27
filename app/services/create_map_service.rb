class CreateMapService

  Combo = [
    ["ab", "168d4f"],
    ["ar", "ffffb1"],
    ["az", "d45500"],
    ["be", "b5ff64"],
    # ["bos", "abc837"],
    # other bosnian. I have sh
    ["bg", "36ae22"],
    ["br", "178df0"],
    ["ca", "00ffff"],
    # ["cau", "d38d5f"],
    # other caucasian
    # me none
    ["co", "c0003c"],
    ["cs", "00cb60"],
    ["cy", "ff7f29"],
    ["da", "ff5555"],
    ["de", "d09999"],
    ["el", "ffff00"],
    ["en", "ffaaaa"],
    ["es", "acd8ed"],
    ["et", "b7c8be"],
    ["eu", "ffd42a"],
    ["fi", "6f997a"],
    ["fo", "ff0000"],
    ["fr", "53bbb5"],
    ["fy", "d66c74"],
    ["ga", "fd6d3c"],
    ["gag", "c837ab"],
    ["gd", "ff7f2a"],
    ["gl", "00d4aa"],
    # ["hr", "abc837"],
    # my croat
    # other hrv
    ["hu", "ac9d93"],
    ["hy", "008080"],
    ["is", "f19076"],
    ["it", "7bafe0"],
    ["ka", "f4e3d7"],
    ["kk", "deaa87"],
    ["krl", "93ac93"],
    ["lb", "55ddff"],
    ["lij", "f2003c"],
    ["lt", "e9afdd"],
    ["lv", "de87cd"],
    ["mk", "71c837"],
    ["mt", "a0892c"],
    ["nap", "f5003c"],
    ["nl", "f4d7d7"],
    ["no", "ff8080"],
    ["oc", "168d5f"],
    ["os", "985fd3"],
    ["pl", "7ecb60"],
    ["pms", "f2d53c"],
    ["pt", "00d4d4"],
    ["rm", "008079"],
    ["ro", "aaccff"],
    ["ru", "72ff00"],
    ["sc", "c0ee3c"],
    ["scn", "cc003c"],
    ["sco", "168df0"],
    ["se", "cccccc"],
    # se is my sami
    # sh x2
    ["sh", "abc837"],
    ["sk", "42f460"],
    ["sl", "81c98d"],
    ["sq", "a0856c"],
    # ["srp", "abc837"],
    # other serb
    ["sv", "ffb380"],
    ["tk", "cc9e4c"],
    ["tt", "c7a25f"],
    ["uk", "c1ff00"],
    ["vnc", "f28d3c"],
    # ["ven", "f28d3c"],
    # vnc is my veneitian. ven is other
    ["xal", "d34d5f"],
    # 63
  ]

  Families_list = ["Tartessian", "Kipchak", "Kipchak-Nogai", "Albanian", "Oghuz", "Finnic", "Etruscan", "Hellenic", "Sami", "Celtic", "Yukaghir", "South", "Armenian", "Koreanic", "Anatolian", "Circassian", "Svan", "Yeniseian", "Indo-Iranian", "Zan", "Viet", "Basque", "Egyptian", "Ainu", "Tocharian", "Kipchak-Bulgar", "Nivkh", "Ugric", "Khmeric", "Kusunda", "Burushkaski", "Karluk", "Balto‑Slavic", "Vasconic", "Sumerian", "Chukotko-Kamchatkan ", "Semitic", "Elamite", "South Central", "Iberian", "Proto-Germanic", "Abkhaz-Abaza", "Proto-Slavic", "Latin", "Proto-Turkic", "Proto-Baltic", "Ancient Greek"] 
  # "Proto-Italic"

  # # The $___ from my_europe_template.svg
  # My_europe_svg = ["ab", "ar", "az", "be", "bg", "br", "ca", "co", "cs", "cy", "da", "de", "el", "en", "es", "et", "eu", "fi", "fo", "fr", "fy", "ga", "gag", "gd", "gl", "hu", "hy", "is", "it", "ka", "kk", "krl", "lb", "lij", "lt", "lv", "mk", "mt", "nap", "nl", "no", "oc", "os", "pl", "pms", "pt", "rm", "ro", "ru", "sc", "scn", "sco", "se", "sh", "sh", "sh", "sk", "sl", "sq", "sv", "tk", "tt", "uk", "vnc", "xal"]
  # # 65 with 2 dupe "sh" 63

  def self.find_all_translations_by_area_img(area, word)
    # get the relevant info from the DB
    search_results = Translation.find_all_translations_by_area(area, word)

    # result after processing, this is what gets placed on the map
    result_array = []
    # => result_array = [[nl, water], ["uk", "мідь - midʹ"]... ]

    # all the current langs. Used to find & delete missing "$__" from the map
    current_languages = []
    # ["ar", "mt", ...]

    # get the selected blank map, open it, and get the $langs from it. Not hardcoded like before.
    doc = File.open("#{Rails.root.to_s}/public/my_europe_template.svg"){ |f| Nokogiri::XML(f) }
    map_langugaes = doc.css("tspan:contains('$')").text().split("$").sort.reject!{ |c| c.empty? }

    # clean the result data for appending
    search_results.each do |result|
      # remove languages that ARE in the results, but NOT on this map
      if !map_langugaes.include?(result.abbreviation)
        next
      end

      # handle romanization
      result_array << romanization_helper(result)[0].to_h
      current_languages << result.abbreviation
    end

    filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
    file_source = filename.read()

    # change the "$__" to result
    for language in result_array
      file_source = file_source.sub("$" + language[:abbreviation], language[:translation])
    end
    
    # languages that ARE on the map, but NOT in the reults
    # unused_map_languages = My_europe_svg - current_languages
    unused_map_languages = map_langugaes - current_languages
    
    # change the "$__" to "" to hide missing info.
    for unused_language in unused_map_languages
      file_source = file_source.sub("$" + unused_language, "")
    end

    send_map(file_source)
  end

  def self.find_all_genders_by_area_img(area, word)
    search_results = Translation.find_all_translations_by_area(area, word)
    languages_array = Combo.map { |item| item[0] }
    color_codes_array = Combo.map { |item| item[1] }
    result_array = []
    current_languages = []
    doc = File.open("#{Rails.root.to_s}/public/my_europe_template.svg"){ |f| Nokogiri::XML(f) }
    map_langugaes = doc.css("tspan:contains('$')").text().split("$").sort.reject!{ |c| c.empty? }

    search_results.each do |result|

      # remove results that are not on this map
      if !map_langugaes.include?(result.abbreviation)
        next
      end

      # remove results with no gender
      if result.gender.nil?
        next
      end

      # handle romanization 
      edited_result = romanization_helper(result)[0].to_h

      # another way
      # .gsub(160.chr("UTF-8"),32.chr("UTF-8"))
      edited_result[:gender] = result.gender.sub(/\302\240/, " ") 
      result_array << edited_result
      current_languages << result.abbreviation
    end

    filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
    file_source = filename.read()

    # remove unused "$__" from map and give gray color
    unused_map_languages = map_langugaes - current_languages
    for unused_language in unused_map_languages
      # if the language exists, grab its color
      if languages_array.include?(unused_language)
        existing_color = color_codes_array[languages_array.find_index(unused_language)]
      end
      if !existing_color.nil?
        file_source = file_source.gsub("#" + existing_color, "#FFFFFF")
        file_source = file_source.sub("$" + unused_language, "")
      end
    end

    # Change "$__" to result
    for language in result_array
      file_source = file_source.sub("$" + language[:abbreviation], language[:translation])

      gender_color = ""
      case language[:gender] 
      # when nil
      #   gender_color = "FFFFFF"
      # when ""
      #   gender_color = "FFFFFF"
      when "m"
        gender_color = "87CEFA"
      when "m inan"
        gender_color = "87CEFA"
      when "m anim"
        gender_color = "87CEFA"
      when "m pl"
        gender_color = "87CEFA"
      when "m or f"
        gender_color = "87CEFA"
      when "f"
        gender_color = "FFC0CB"
      when "f pl"
        gender_color = "FFC0CB"
      when "f or m"
        gender_color = "FFC0CB"
      when "n"
        gender_color = "D3D3D3"
      when "n inan"
        gender_color = "D3D3D3"
      when "c"
        gender_color = "D3D3D3"
      else
        gender_color = "FFFFFF"
      end
   
      existing_color = nil

      # if the current language is on the map, find its corresponding color, existing_color
      if languages_array.include?(language[:abbreviation])
        existing_color = color_codes_array[languages_array.find_index(language[:abbreviation])]
      end

      # change the existing_color to the gender_color on the map
      if !existing_color.nil?
        file_source = file_source.gsub("#" + existing_color, "#" + gender_color)
      end
    end

    send_map(file_source)
  end

  def self.find_all_etymologies_by_area_img(area, word)
    search_results = Translation.find_all_translations_by_area(area, word)
    languages_array = Combo.map { |item| item[0] }
    color_codes_array = Combo.map { |item| item[1] }
    result_array = []

    # the array that etymologies are checked against to see if they are shared or not.
    etymology_array = []
    # =>  {:etymology=>"Borrowed from English copper.",
    #   :languages=>["ga", "gd"],
    #   :color=>"fd6d3c"},
    #   :family=>"Proto-Celtic"}]

    current_languages = []
    array_counter = 0

    doc = File.open("#{Rails.root.to_s}/public/my_europe_template.svg"){ |f| Nokogiri::XML(f) }
    map_langugaes = doc.css("tspan:contains('$')").text().split("$").sort.reject!{ |c| c.empty? }

    search_results.each do |result|

      # ignore search_results that are not on this map
      if !map_langugaes.include?(result.abbreviation)
        next
      end

      # ignore search_results with no etymology
      if result.etymology.nil?
        next
      end

      current_unclean_etymology_array = result.etymology.split(/[,.]\s*/)
      # clean the etymology
      current_clean_etymology = result.etymology.gsub(/\bborrowed\b/i,"").gsub(/\bfrom\b/i,"").strip().downcase
      # convert it to an array separated by [,.]
      current_clean_etymology_array = current_clean_etymology.split(/[,.]\s*/)

      # loop over the proto families. try to match the current_clean_etymology_array info to one in there.
      matching_family = Families_list.select do |fam|
        current_clean_etymology.include?(fam.downcase)
      end.first

      # if none, use the etymology
      if matching_family.nil?
        matching_family = result.etymology
      end

      if ["sq", "lt", "el", "az"].include?(result.abbreviation)
        byebug
      end

      # get the index of the current_clean_etymology_array that matches the family
      matching_clean_ety_ar_index = 0
      matching_clean_ety_ar_index = current_clean_etymology_array.find_index do |item|
        item.include?(matching_family.downcase)
      end
   
      # get the etymology
      current_clean_matching_etymology = ""

      if !matching_clean_ety_ar_index.nil?
        current_clean_matching_etymology = current_clean_etymology_array[matching_clean_ety_ar_index]
      else
        current_clean_matching_etymology = result.etymology
      end

      puts "langauge= #{result.abbreviation}"
      puts "etymology= #{result.etymology.slice(0..100)}"
      puts "current_clean_etymology= #{current_clean_etymology.slice(0..100)}"
      puts "current_clean_etymology_array= #{current_clean_etymology_array}"
      puts "matching_family= #{matching_family}"
      puts "matching_clean_ety_ar_index= #{matching_clean_ety_ar_index}"
      puts "current_clean_matching_etymology= #{current_clean_matching_etymology}"
      puts "==============================================================="
      puts "\n"
      
      # find the index of the current_etymology in etymology_array, if any
      # index_in_ety_array = etymology_array.find_index { |item| item && item[:etymology].include?(current_clean_matching_etymology) }
      # index_in_ety_array = etymology_array.find_index { |item| item && item[:etymology].include?(current_etymology.to_s) }

      # byebug
      index_in_ety_array = etymology_array.find_index do |item| 
        item && item[:family].include?(matching_family)
      end

      # if result.etymology IS null/nil, append nil as the number and blank as color.
      # nothing goes into the etymology_array
      if result.etymology.nil? || result.etymology == "Null"
        edited_result = romanization_helper(result)[0].to_h
        edited_result[:index] = nil
        edited_result[:color] = "FFFFFF"
        result_array << edited_result

      # if result.etymology IS an etymology, but it is NOT in the array, it will have nil as index_in_ety_array
      # push it in array with its own default color
      elsif index_in_ety_array.nil?

        # set default color to missing. If it later is found, use found_color
        found_color = "FFFFFF"
        if languages_array.find_index(result[:abbreviation])
          found_color = color_codes_array[languages_array.find_index(result[:abbreviation])] 
        end

        # push the etymology, language, and color into the etymology_array 
        # byebug
        etymology_array << {etymology: current_clean_matching_etymology, languages: [result.abbreviation], color: found_color, family: matching_family }
        
        # push result into the result_array
        edited_result = romanization_helper(result)[0].to_h
        edited_result[:index] = array_counter
        edited_result[:color] = found_color
        edited_result[:family] = matching_family
        result_array << edited_result

        # add result to current_langauges
        current_languages << result.abbreviation
        array_counter += 1

      # there IS an etymology, and it IS in the etymology_array
      else
        # add this language to the etymology_array
        etymology_array[index_in_ety_array][:languages] << result.abbreviation
        # etymology_array[index_in_ety_array][:family] << matching_family

        # get the corresponding color
        found_color = etymology_array[index_in_ety_array][:color]

        # put the info into the result_array
        edited_result = romanization_helper(result)[0].to_h
        edited_result[:index] = index_in_ety_array
        edited_result[:color] = found_color
        edited_result[:family] = matching_family
        result_array << edited_result
        current_languages << result.abbreviation
      end
    end

    filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
    file_source = filename.read()

    # remove unused langs $__ from map and color it blank
    unused_map_languages = map_langugaes - current_languages

    for unused_language in unused_map_languages
      file_source = file_source.sub("$" + unused_language, "")
      color_from_map = color_codes_array[languages_array.find_index(unused_language)]
      file_source = file_source.gsub("#" + color_from_map, "#FFFFFF" )
    end

    # Update the map text and color
    for language in result_array

      # put the result text on the map. => [мідь - midʹ]
      file_source = file_source.sub("$" + language[:abbreviation], "#{language[:translation]}")

      # change the result color on the map
      color_from_map = "ffffff"
      # color_from_map = "d9d9d9"
      if languages_array.include?(language[:abbreviation])
        color_from_map = color_codes_array[languages_array.find_index(language[:abbreviation])]
      end
      file_source = file_source.gsub("#" + color_from_map, "#" + language[:color] )

    end
    pp etymology_array
    puts etymology_array.length
  
    send_map(file_source)
  end

  def self.send_map(file_source)
    FileUtils.copy_entry("public/my_europe_template.svg", "public/my_europe_copy_template.svg", preserve = false, dereference = false, remove_destination = true)
    the_new_map = open("public/my_europe_copy_template.svg", "w")
    the_new_map.write(file_source)
    # the_new_map.close()
    the_new_map
    # send_file the_new_map, disposition: :inline
  end

  # Appends romanization if not the same as translation
  # example [nl, water], ["uk", "мідь - midʹ"]
  def self.romanization_helper(result)
    if result.translation == result.romanization
      [abbreviation: "#{result.abbreviation}", translation: "#{result.translation}"]
    else
      [abbreviation: "#{result.abbreviation}", translation: "#{result.translation} - #{result.romanization}"]
    end
  end

end