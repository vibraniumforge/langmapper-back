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

  # x = doc.xpath('//*[contains(@style,"fill")]')[0].attributes["style"].children.to_s
  # x.slice(x.index("#)", 11)

  Families_list = ["Tartessian", "Kipchak", "Kipchak-Nogai", "Albanian", "Oghuz", "Finnic", "Etruscan", "Hellenic", "Sami", "Celtic", "Yukaghir", "South", "Armenian", "Koreanic", "Anatolian", "Circassian", "Svan", "Yeniseian", "Indo-Iranian", "Zan", "Viet", "Basque", "Egyptian", "Ainu", "Tocharian", "Kipchak-Bulgar", "Nivkh", "Ugric", "Khmeric", "Kusunda", "Burushkaski", "Karluk", "Balto‑Slavic", "Vasconic", "Sumerian", "Chukotko-Kamchatkan ", "Semitic", "Elamite", "South Central", "Iberian", "Proto-Germanic", "Abkhaz-Abaza", "Proto-Slavic", "Latin", "Proto-Turkic", "Proto-Baltic", "Ancient Greek"] 
  # "Proto-Italic"

  # # The $___ from my_europe_template.svg
  # My_europe_svg = ["ab", "ar", "az", "be", "bg", "br", "ca", "co", "cs", "cy", "da", "de", "el", "en", "es", "et", "eu", "fi", "fo", "fr", "fy", "ga", "gag", "gd", "gl", "hu", "hy", "is", "it", "ka", "kk", "krl", "lb", "lij", "lt", "lv", "mk", "mt", "nap", "nl", "no", "oc", "os", "pl", "pms", "pt", "rm", "ro", "ru", "sc", "scn", "sco", "se", "sh", "sh", "sh", "sk", "sl", "sq", "sv", "tk", "tt", "uk", "vnc", "xal"]
  # # 65 with 2 dupe "sh" 63

  def self.find_all_translations_by_area_img(area, word)
    # get the relevant info from the DB
    search_results = Translation.find_all_translations_by_area(area, word)

    # result after processing, this is what gets placed on the map
    # => result_array = [[nl, water], ["uk", "мідь - midʹ"]... ]
    result_array = []

    # all the current langs. Used to find & delete missing "$__" from the map
    # => ["ar", "mt", ...]
    current_languages = []

    # open the selected blank map, read it, and get the $langs from it. 
    # Not hardcoded like before in My_europe_svg.
    map_file = File.open("#{Rails.root.to_s}/public/my_europe_template.svg")
    map_code = map_file.read
    map_languages = map_code.scan(/[$][a-z]{2,3}/mi).sort.map{|x| x.gsub(/[$]/i, "")}
    map_file.close

    # clean the result data for appending
    search_results.each do |result|

      # skip languages that ARE in the results, but NOT on this map
      if !map_languages.include?(result.abbreviation)
        next
      end

      # handle romanization of other scripts
      result_array << romanization_helper(result)[0].to_h
      current_languages << result.abbreviation
    end

    # languages that ARE on the map, but NOT in the reults
    unused_map_languages = map_languages - current_languages

    # change the "$__" to "" to hide missing info.
    for unused_language in unused_map_languages
      map_code = map_code.sub("$" + unused_language, "")
    end

    # change the "$__" to the result translation
    for result in result_array
      map_code = map_code.sub("$" + result[:abbreviation], result[:translation])
    end

    map_file.close

    send_map(map_code)
  end

  def self.find_all_genders_by_area_img(area, word)
    search_results = Translation.find_all_translations_by_area(area, word)
    languages_array = Combo.map { |item| item[0] }
    color_codes_array = Combo.map { |item| item[1] }
    result_array = []
    current_languages = []

    map_file = File.open("#{Rails.root.to_s}/public/my_europe_template.svg")
    map_code = map_file.read
    map_languages = map_code.scan(/[$][a-z]{2,3}/mi).sort.map{|x| x.gsub(/[$]/i, "")}
    map_file.close

    search_results.each do |result|

      # skip results that are not on this map
      if !map_languages.include?(result.abbreviation)
        next
      end

      # skip results with no gender
      if result.gender.nil?
        next
      end

      # handle romanization 
      edited_result = romanization_helper(result)[0].to_h

      # clean the gender text
      # another way
      # .gsub(160.chr("UTF-8"), 32.chr("UTF-8"))
      edited_result[:gender] = result.gender.sub(/\302\240/, " ") 

      result_array << edited_result
      current_languages << result.abbreviation
    end

    # get the genders of French and Italian.
    # they are the base color to remove missing regional languages
    italian_index = result_array.find_index{|x| x[:abbreviation] == "it" }
    french_index = result_array.find_index{|x| x[:abbreviation] == "fr" }
    italian_gender = !italian_index.nil? ? result_array[italian_index][:gender] : nil
    french_gender = !french_index.nil? ? result_array[french_index][:gender] : nil

    # remove unused "$__" from map and give gray color
    unused_map_languages = map_languages - current_languages
    for unused_language in unused_map_languages

      # change the "$__" to "" to hide missing info.
      map_code = map_code.sub("$" + unused_language, "")

      # get the unused_language's color from the map
      color_from_map = color_codes_array[languages_array.find_index(unused_language)]

      # color the missing regional languages to their national ones
      if ["pms", "lij", "vnc", "nap", "scn", "sc"].include?(unused_language) && !italian_gender.nil?
        map_code = map_code.gsub("#" + color_from_map, "#" + gender_color_finder(italian_gender) )
      elsif ["oc", "co", "br"].include?(unused_language) && !french_gender.nil? 
        map_code = map_code.gsub("#" + color_from_map, "#" + gender_color_finder(french_gender) )
      else
        map_code = map_code.gsub("#" + color_from_map, "#" + "ffffff" )
      end
    end

    # change "$__" to result translation, 
    # change the color to the right color
    for result in result_array
      map_code = map_code.sub("$" + result[:abbreviation], result[:translation])

      existing_color = nil

      # if the current language is on the map, find its corresponding color, existing_color
      if languages_array.include?(result[:abbreviation])
        existing_color = color_codes_array[languages_array.find_index(result[:abbreviation])]
      end

      # change the existing_color to the gender_color on the map
      if !existing_color.nil?
        map_code = map_code.gsub("#" + existing_color, "#" + gender_color_finder(result[:gender]))
      end
    end

    map_file.close
    
    send_map(map_code)
  end

  # pick the right color for the matching gender
  def self.gender_color_finder(gender)
  
    gender_color = ""
    case gender
    # when nil
    #   gender_color = "FFFFFF"
    # when ""
    #   gender_color = "FFFFFF"
    when "m"
      gender_color = "87CEFA"
    when "m anim"
      gender_color = "87CEFA"
    when "m inan"
      gender_color = "87CEFA"
    when "m pl"
      gender_color = "87CEFA"
    when "m or f"
      gender_color = "87CEFA"
    when "m or n"
      gender_color = "87CEFA"
    when "f"
      gender_color = "FFC0CB"
    when "f pl"
      gender_color = "FFC0CB"
    when "f inan"
      gender_color = "FFC0CB"
    when "f or m"
      gender_color = "FFC0CB"
    when "n"
      gender_color = "D3D3D3"
    when "n inan"
      gender_color = "D3D3D3"
    when "c"
      gender_color = "EE82EE"
    else
      gender_color = "FFFFFF"
    end
    gender_color
  end

  def self.send_map(map_code)
    FileUtils.copy_entry("public/my_europe_template.svg", "public/my_europe_template_copy.svg", preserve = false, dereference = false, remove_destination = true)
    the_new_map = open("public/my_europe_template_copy.svg", "w")
    the_new_map.write(map_code)
    # the_new_map.close
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