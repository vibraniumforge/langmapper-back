class CreateEtymologyMapService

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
    # 63 total
  ]

  Families_list = ["Albanian", "Anatolian", "Armenian", "Ancient Greek", "Hellenic", "Latin", "Proto-Balto‑Slavic", "Proto-Slavic", "Proto-Baltic", "Proto-Celtic", "Proto-Germanic", "Proto-Indo-Iranian", "Proto-Tocharian", "Proto-Finnic", "Proto-Sami", "Proto-Ugric", "Proto-Basque", "Proto-Turkic", "Proto-Afro-Asiatic" ,"Semitic", "Proto-Kartvelian", "Proto-Northwest Caucasian" ] 
  # "Proto-Italic",

  # # The $___ from my_europe_template.svg
  My_europe_svg = ["ab", "ar", "az", "be", "bg", "br", "ca", "co", "cs", "cy", "da", "de", "el", "en", "es", "et", "eu", "fi", "fo", "fr", "fy", "ga", "gag", "gd", "gl", "hu", "hy", "is", "it", "ka", "kk", "krl", "lb", "lij", "lt", "lv", "mk", "mt", "nap", "nl", "no", "oc", "os", "pl", "pms", "pt", "rm", "ro", "ru", "sc", "scn", "sco", "se", "sh", "sh", "sh", "sk", "sl", "sq", "sv", "tk", "tt", "uk", "vnc", "xal"]
  # 65 with 2 dupe "sh" 63

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

    #<Nokogiri::XML::Attr:0x3fc15a080254 name="style" value="fill:#ffffb1;fill-opacity:1;stroke:#ffffff;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1">

    doc = File.open("#{Rails.root.to_s}/public/my_europe_template.svg"){ |f| Nokogiri::XML(f) }
    map_langugaes = doc.css("tspan:contains('$')").text().split("$").sort.reject!{ |c| c.empty? }
    
    # map_colors = doc.xpath('//*[contains(@style,"fill")]')[0].attributes["style"].children.to_s
    # x = doc.xpath('//*[contains(@style,"fill")]')
    # y = x[0].attributes["style"].children.to_s
    # x[0]["style"].slice(x[0]["style"].index("#") + 1, 6)
    # x[0]["style"].slice(6, 6)

    search_results.each do |result|

      # get a result
      # check if it is on the map
      # check if it has an etymology
      # current_etymology_array - split the etymology by sentence
      # get the families list. Match current_etymology_array and family
      # if no matching_family, use the result.family
      # if no matching_etymology, use the result.etymology
      # get the index_in_ety_array of the matching etymology from etymology)_array
      # build the etymology array
      # build the result array

      # ignore search_results that are not on this map
      if !map_langugaes.include?(result.abbreviation)
        next
      end

      # ignore search_results with no etymology
      if result.etymology.nil?
        next
      end

      # remove everything after first sentence. Split on commas.
      current_etymology_array = result.etymology.split(".")[0].split(/ *, *(?=[^\)]*?(?:\(|$))/)

      # loop and find the matching_family from the Families_list
      # loop and find the matching_etymology from the result.etymology
      matching_family = nil
      matching_etymology = nil
      matched = false
      current_etymology_array.each do |etymology|
        Families_list.each do |family|
          # if etymology.include?("From #{family}") || etymology.include?("from #{family}") 
          if etymology.include?("From #{family}") || etymology.include?("from #{family}") && !matched
            # if ["ru"].include?(result.abbreviation)
            #   byebug
            # end
            matching_family = family
            if ["Borrowed", "borrowd"].include?(etymology.split(" ").first) 
              # remove (english gold) etc. Capitalize. Helps with matching later
              matching_etymology = etymology.gsub(/\bborrowed\b/i,"").gsub(/\s*\(.+\)$/, '').strip().slice(0,1).capitalize + etymology.gsub(/\bborrowed\b/i,"").gsub(/\s*\(.+\)$/, '').strip().slice(1..-1)
            else
              matching_etymology = etymology.gsub(/\s*\(.+\)$/, '').strip().slice(0,1).capitalize + etymology.gsub(/\s*\(.+\)$/, '').strip().slice(1..-1)
              # matching_etymology = etymology.gsub(/\bborrowed\b/i,"").gsub(/\s*\(.+\)$/, '').strip()
            end
            matched = true
            # break
          end
        end
      end

      # if matching_family, it may be new. use the result.family
      if matching_family.nil?
        matching_family = result.family
      end

      # if matchimatching_etymologyg_family, it may be new. use the result.etymology
      if matching_etymology.nil?
        matching_etymology = current_etymology_array.first
      end

      puts "langauge= #{result.abbreviation}"
      puts "etymology= #{result.etymology.slice(0..100)}"
      puts "current_etymology_array= #{current_etymology_array}"
      puts "matching_family= #{matching_family}"
      puts "matching_etymology= #{matching_etymology}"
      puts "==============================================================="
      puts "\n"
      
      # find the index of the current_etymology in etymology_array, if any

      # index_in_ety_array = etymology_array.find_index { |item| item && item[:etymology].include?(current_clean_matching_etymology) }
      # index_in_ety_array = etymology_array.find_index { |item| item && item[:etymology].include?(current_etymology.to_s) }

      index_in_ety_array = etymology_array.find_index do |item| 
        # if ["az", "lt", "lv"].include?(result.abbreviation)
        #   byebug
        # end
        # item && item[:family].include?(matching_family)
        item && item[:etymology].include?(matching_etymology)
      end
     
      # if result.etymology IS null/nil, append nil as the number and blank as color.
      # NOTHING goes into the etymology_array. bc no ety to begin with
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
        # the_index = index_in_ety_array ? index_in_ety_array : 0

        etymology_array << {etymology: matching_etymology, languages: [result.abbreviation, ], color: found_color, family: matching_family }
        
        # push result into the result_array
        edited_result = romanization_helper(result)[0].to_h
        edited_result[:index] = array_counter
        edited_result[:color] = found_color
        # edited_result[:family] = matching_family
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
    # remove unused regional langs and color to larger lang if necessary
    unused_map_languages = map_langugaes - current_languages
    for unused_language in unused_map_languages
      italian_color = result_array.select{|x| x[:abbreviation] == "it" }[0][:color]
      english_color = result_array.select{|x| x[:abbreviation] == "en" }[0][:color]
      french_color = result_array.select{|x| x[:abbreviation] == "fr" }[0][:color]

      # set the text to ""
      file_source = file_source.sub("$" + unused_language, "")

      # find the corresponding color
      color_from_map = color_codes_array[languages_array.find_index(unused_language)]

      # change the color. 
      if ["pms", "lij", "vnc", "nap", "scn", "sc"].include?(unused_language) && italian_color != "ffffff"
        file_source = file_source.gsub("#" + color_from_map, "#" + italian_color )
      elsif unused_language == "sco" && english_color != "ffffff"
        file_source = file_source.gsub("#" + color_from_map, "#" + english_color )
      elsif unused_language == "co" && french_color != "ffffff"
        file_source = file_source.gsub("#" + color_from_map, "#" + french_color )
      else
        file_source = file_source.gsub("#" + color_from_map, "#" + "ffffff" )
      end
    end

    # Update the map text and color for exitsting etymologies
    for language in result_array

      # put the result text on the map. => [мідь - midʹ]
      file_source = file_source.sub("$" + language[:abbreviation], "#{language[:translation]}")

      # change the result color on the map
      color_from_map = "ffffff"
      # color_from_map = "d9d9d9"
      if languages_array.include?(language[:abbreviation])
        color_from_map = color_codes_array[languages_array.find_index(language[:abbreviation])]
      end
      file_source = file_source.gsub("#" + color_from_map, "#" + language[:color])
    end

    pp etymology_array
    puts "\n"
    puts "#{map_langugaes.length} languages on the map"
    puts "#{search_results.length} languages in the DB for this word #{word} in #{area}"
    puts "#{unused_map_languages.length} unused languages"
    puts "#{etymology_array.length} etymologies"
    puts "#{current_languages.length} languages"
    puts "#{(My_europe_svg - map_langugaes).count} languages missing between the two arrays"
    puts "\n"
  
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