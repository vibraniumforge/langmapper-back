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
  ]

  # The $___ from my_europe_template.svg
  My_europe_svg = ["ab", "ar", "az", "be", "bg", "br", "ca", "co", "cs", "cy", "da", "de", "el", "en", "es", "et", "eu", "fi", "fo", "fr", "fy", "ga", "gag", "gd", "gl", "hu", "hy", "is", "it", "ka", "kk", "krl", "lb", "lij", "lt", "lv", "mk", "mt", "nap", "nl", "no", "oc", "os", "pl", "pms", "pt", "rm", "ro", "ru", "sc", "scn", "sco", "se", "sh", "sh", "sh", "sk", "sl", "sq", "sv", "tk", "tt", "uk", "vnc", "xal"]

  def self.find_all_translations_by_area_img(area, word)
    puts "FIRES"
    # get the relevant info from the DB
    search_results = Translation.find_all_translations_by_area(area, word)
    # result after processing, this is what gets placed on the map
    result_array = []
    # => result_array = [[nl, water], ["uk", "мідь - midʹ"]... ]

    # all the current langs. Used to find & delete missing "$__" from the map
    current_languages = []
    # ["ar", "mt", ...]

    search_results.each do |result|
      # remove languages that ARE in the results, but NOT on this map
      if !My_europe_svg.include?(result.abbreviation)
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
    unused_map_languages = My_europe_svg - current_languages
    
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

    search_results.each do |result|

      # remove results that are not on this map
      if !My_europe_svg.include?(result.abbreviation)
        next
      end

      # handle romanization 
      info = romanization_helper(result)[0].to_h
      info[:gender] = result.gender
      result_array << info
      current_languages << result.abbreviation
    end

    filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
    file_source = filename.read()

    # remove unused "$__" from map and give gray color
    unused_map_languages = My_europe_svg - current_languages
    for unused_language in unused_map_languages
      if languages_array.include?(unused_language)
        existing_color = color_codes_array[languages_array.find_index(unused_language)]
      end
      if !existing_color.nil?
        file_source = file_source.gsub("#" + existing_color, "#D3D3D3")
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
      when "f"
        gender_color = "FFC0CB"
      when "n"
        gender_color = "D3D3D3"
      when "n inan"
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

    current_languages = []
    array_counter = 0

    search_results.each do |result|

      # ignore search_results that are not on this map
      if !My_europe_svg.include?(result.abbreviation)
        next
      end

      # clean the etymology
      current_etymology = result.etymology&.strip
      
      # find the index of the current_etymology in etymology_array, if any
      index_in_ety_array = etymology_array.find_index { |item| item && item[:etymology].include?(current_etymology.to_s) }

      # if result.etymology IS null/nil, append nil as the number and blank as color
      if result.etymology.nil? || result.etymology == "Null"
        info = romanization_helper(result)[0].to_h
        info[:index] = nil
        info[:color] = "d9d9d9"
        result_array << info

      # if result.etymology IS an etymology, but it is NOT in the array, it will have nil as index_in_ety_array
      # push it in array with default color
      elsif index_in_ety_array.nil?

        # set default color to missing. If it later is found, use found_color
        found_color = "d9d9d9"
        if languages_array.find_index(result[:abbreviation])
          found_color = color_codes_array[languages_array.find_index(result[:abbreviation])] 
        end

        # push the etymology, language, and color into the etymology_array 
        etymology_array << {etymology: current_etymology, languages: [result.abbreviation], color: found_color }

        # push result into the result_array
        info = romanization_helper(result)[0].to_h
        info[:index] = array_counter
        info[:color] = found_color
        result_array << info

        # add result to current_langauges
        current_languages << result.abbreviation
        array_counter += 1

      # there IS an etymology, and it IS in the etymology_array
      else
        # add this language to the etymology_array
        etymology_array[index_in_ety_array][:languages] << result.abbreviation

        # get the corresponding color
        found_color = etymology_array[index_in_ety_array][:color]

        # put the info into the result_array
        info = romanization_helper(result)[0].to_h
        info[:index] = index_in_ety_array
        info[:color] = found_color
        result_array << info
      end
      current_languages << result.abbreviation
    end

    filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
    file_source = filename.read()

    # remove unused langs $__ from map and color it blank
    unused_map_languages = My_europe_svg - current_languages

    for unused_language in unused_map_languages
      file_source = file_source.sub("$" + unused_language, "")
      color_from_map = color_codes_array[languages_array.find_index(unused_language)]
      file_source = file_source.gsub("#" + color_from_map, "#d9d9d9" )
    end

    # Update the map text and color
    for language in result_array

      # put the result text  on the map. => [мідь - midʹ - 5]
      # file_source = file_source.sub("$" + language[:abbreviation], "#{language[:translation]} - #{language[:index]}")

      # put the result text on the map. => [мідь - midʹ]
      file_source = file_source.sub("$" + language[:abbreviation], "#{language[:translation]}")

      # change the result color on the map
      color_from_map = "d9d9d9"
      if languages_array.include?(language[:abbreviation])
        color_from_map = color_codes_array[languages_array.find_index(language[:abbreviation])]
      end
      file_source = file_source.gsub("#" + color_from_map, "#" + language[:color] )

    end
  
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