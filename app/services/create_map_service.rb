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
      # .gsub(160.chr("UTF-8"), 32.chr("UTF-8"))
      edited_result[:gender] = result.gender.sub(/\302\240/, " ") 
      result_array << edited_result
      current_languages << result.abbreviation
    end

    filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
    file_source = filename.read()

    # remove unused "$__" from map and give gray color
    unused_map_languages = map_langugaes - current_languages
    for unused_language in unused_map_languages
      italian_gender = result_array.select{|x| x[:abbreviation] == "it" }[0][:gender]
      french_gender = result_array.select{|x| x[:abbreviation] == "fr" }[0][:gender]

      file_source = file_source.sub("$" + unused_language, "")
      color_from_map = color_codes_array[languages_array.find_index(unused_language)]

      if ["pms", "lij", "vnc", "nap", "scn", "sc"].include?(unused_language) && italian_gender != nil
        file_source = file_source.gsub("#" + color_from_map, "#" + gender_color_finder(italian_gender) )
      elsif ["oc", "co", "br"].include?(unused_language) && french_gender != nil
        file_source = file_source.gsub("#" + color_from_map, "#" + gender_color_finder(french_gender) )
      else
        file_source = file_source.gsub("#" + color_from_map, "#" + "ffffff" )
      end
    end

    # Change "$__" to result
    for language in result_array
      file_source = file_source.sub("$" + language[:abbreviation], language[:translation])

      existing_color = nil

      # if the current language is on the map, find its corresponding color, existing_color
      if languages_array.include?(language[:abbreviation])
        existing_color = color_codes_array[languages_array.find_index(language[:abbreviation])]
      end

      # change the existing_color to the gender_color on the map
      if !existing_color.nil?
        file_source = file_source.gsub("#" + existing_color, "#" + gender_color_finder(language[:gender]))
      end
    end

    send_map(file_source)
  end

  def self.gender_color_finder(gender)
    # pick the right color for the matching gender
    
    gender_color = ""
    case gender
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
    gender_color
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