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
  # 63 total. No duped sh
  ]

  # The $___ from my_europe_template.svg
  My_europe_svg = ["ab", "ar", "az", "be", "bg", "br", "ca", "co", "cs", "cy", "da", "de", "el", "en", "es", "et", "eu", "fi", "fo", "fr", "fy", "ga", "gag", "gd", "gl", "hu", "hy", "is", "it", "ka", "kk", "krl", "lb", "lij", "lt", "lv", "mk", "mt", "nap", "nl", "no", "oc", "os", "pl", "pms", "pt", "rm", "ro", "ru", "sc", "scn", "sco", "se", "sh", "sk", "sl", "sq", "sv", "tk", "tt", "uk", "vnc", "xal"]
  # 65 with 2 dupe "sh" 63

  Families_list = ["Albanian", "Anatolian", "Armenian", "Ancient Greek", "Hellenic", "Latin", "Proto-Balto-Slavic", "Proto-Slavic", "Proto-Baltic", "Proto-Celtic", "Proto-Germanic", "Proto-Indo-Iranian", "Proto-Tocharian", "Proto-Finnic", "Proto-Sami", "Proto-Ugric", "Proto-Basque", "Proto-Turkic", "Proto-Afro-Asiatic", "Semitic", "Arabic", "Proto-Kartvelian", "Proto-Northwest Caucasian", "Proto-Northeast Caucasian"]
  # "Proto-Italic",

  def self.find_all_etymologies_by_area_img(area, word)
    t1 = Time.now
    # search_results = Translation.find_all_translations_by_area(area, word)

    # below for just default map
    search_results = Translation.find_all_translations_by_area_europe_map(area, word)
    search_results_lang_array = search_results.map { |lang| lang.abbreviation }.sort
    languages_array = Combo.map { |item| item[0] }
    color_codes_array = Combo.map { |item| item[1] }
    result_array = []

    # the array that etymologies are checked against to see if they are shared or not.
    etymology_array = []
    # => [
    # {:etymology=>"Borrowed from English copper.",
    # :languages=>["ga", "gd"],
    # :color=>"fd6d3c"},
    # :family=>"Proto-Celtic"}]

    current_languages = []
    array_counter = 0

    #<Nokogiri::XML::Attr:0x3fc15a080254 name="style" value="fill:#ffffb1;fill-opacity:1;stroke:#ffffff;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1">

    # doc = File.open("#{Rails.root.to_s}/public/my_europe_template.svg"){ |f| Nokogiri::XML(f) }
    # map_languages = doc.css("tspan:contains('$')").text().split("$").sort.reject!{ |c| c.empty? }

    map_file = File.open("#{Rails.root.to_s}/public/my_europe_template.svg")
    map_code = map_file.read
    map_languages = map_code.scan(/[$][a-z]{2,3}/mi).sort.map { |x| x.gsub(/[$]/i, "") }
    # map_file.close

    # map_colors = map_code.scan(/#[a-f0-9]{3}{1,2}/mi).sort.uniq
    # map_colors = doc.xpath('//*[contains(@style,"fill")]')[0].attributes["style"].children.to_s
    # x = doc.xpath('//*[contains(@style,"fill")]')
    # y = x[0].attributes["style"].children.to_s
    # x[0]["style"].slice(x[0]["style"].index("#") + 1, 6)
    # x[0]["style"].slice(6, 6)

    # Matching Logic
    # loop over query results
    # get a result
    # check if it is on the map
    # check if it has an etymology
    # current_etymology_array and clean each individual etymology.
    # split the etymology by sentence, remove anything after first sentence
    # split first sentence on commas. then semicolons.
    # remove_words. strip.
    # this is now clean_etymology
    # loop over Families_list. try to match clean_etymology and one family from Families_list
    # get the families list. Match current_etymology_array[index] and family
    # if no matching_family, use the result.family
    # if no matching_etymology, use the result.etymology
    # get the index_in_ety_array of the matching etymology from etymology_array
    # build the etymology array
    # build the result array

    search_results.each do |result|

      # ignore search_results that are not on this map
      if !map_languages.include?(result.abbreviation)
        next
      end

      # ignore search_results with no etymology
      if result.etymology.nil? || result.etymology.length.zero?
        next
      end

      # (/ *, *(?=[^\)]*?(?:\(|$))/) split on commas
      # gsub(/\[.*?\]/, "") => remove space + brackets and their contents
      # gsub(/\s\(.*?\)/, '') => remove space + parenthesis and their contents
      # remove everything after first sentence. Split on commas.
      # current_etymology_array = result.etymology.split(".")[0].split(/ *, *(?=[^\)]*?(?:\(|$))/)
      # current_etymology_array = result.etymology.gsub(/\(.*?\)/, '').split(".")[0].split(/ *, *(?=[^\)]*?(?:\(|$))/)
      # current_etymology_array = result.etymology.gsub(/\s\(.*?\)/, "").gsub(/\s\[.*?\]/, "").split(".")[0].split(/\s*[,;]\s*/)
      # current_etymology_array = result.etymology.gsub(/\s\(.*?\)/, "").gsub(/\(.*\)/, "").gsub(/\(.*\)/, "").split(".")[0].split(/\s*[,;]\s*/)
      current_etymology_array = result.etymology.gsub(/\[.*?\]|\s\[.*?\]|\(.*?\)|\s\(.*?\)/, "").split(".")[0].split(/\s*[,;]\s*/)

      matching_family = nil
      matching_etymology = nil
      matched = false

      # Words that confuse the match
      remove_words = ["ultimately", "derived", "borrowed", "shortened", "by", "metathesis", "both", "all", "the", "voiced", "verner", "alternant", "classical", "with", "change", "of", "ending", "itself", "probably", "later", "late", "vulgar", "a", "modification", "root", "or", "borrowing", "learned", "semi-learned", "conflation", "via", "taken", "either", "regularized", "regularised", "form", "medieval", "diminutive", "variant", "through", "prothesis", "literary", "taken", "reformation", "inherited", "feminine", "masculine", "hypothetical", "reborrowing", "plural", "despite", "being", "in", "fact", "uncertain", "origin", "derivative", "eventually", "less", "likely"]

      # Prefer "Latin" instead of "Vulgar Latin".
      # Account for "from Vulgar Latin "xe", from Latin "x" confusion.
      num_latins = current_etymology_array.select do |item|
        item.include?("Latin")
      end.length
      vulgar_latin_index = current_etymology_array.find_index do |item|
        item.include?("Vulgar Latin")
      end
      if num_latins > 1 && vulgar_latin_index
        current_etymology_array.delete_at(vulgar_latin_index)
      end

      # matching logic
      current_etymology_array.each do |etymology|
        # clean the current etymology, one item in the current_etymology_array
        # clean_etymology = etymology.strip.split(" ").delete_if{|word| remove_words.include?(word.downcase)}.join(" ").parameterize(separator: " ")
        clean_etymology = etymology.strip.split(" ").delete_if { |word| remove_words.include?(word.downcase) }.join(" ")

        # loop over the families. Try to match wods in clean_etymology to a family name.
        Families_list.each do |family|
          if clean_etymology.downcase.include?("from #{family.downcase}") || clean_etymology.downcase.include?("From #{family.downcase}")
            matching_family = family
            matching_etymology = clean_etymology.slice(0, 1).capitalize + clean_etymology.strip().slice(1..-1)
            matched = true
            break
          end
          break if matched
        end
      end

      # if matching_family, it may be new. use the result.family
      if matching_family.nil?
        matching_family = result.family
      end

      # if matching_etymology, it may be new. use the result.etymology
      if matching_etymology.nil?
        matching_etymology = current_etymology_array.first
      end

      # find the index of the current_etymology in etymology_array, if any
      index_in_ety_array = etymology_array.find_index do |item|
        # (item && item[:etymology].include?(matching_etymology))
        (item && item[:etymology].parameterize.include?(matching_etymology.parameterize))
      end

      # puts "langauge= #{result.abbreviation}"
      # puts "etymology= #{result.etymology.slice(0..100)}"
      # # puts "current_etymology_array= #{current_etymology_array}"
      # # puts "matching_family= #{matching_family}"
      # puts "matching_etymology= #{matching_etymology}"
      # puts "index_in_ety_array= #{index_in_ety_array}"
      # puts "==============================================================="
      # puts "\n"

      # if result.etymology IS null/nil, append nil as the index and blank as color.
      # NOTHING goes into the etymology_array. bc no ety to begin with
      if result.etymology.nil? || result.etymology == "Null"
        edited_result = romanization_helper(result)[0].to_h
        edited_result[:index] = nil
        edited_result[:color] = "ffffff"
        result_array << edited_result

        # if result.etymology IS an etymology, but it is NOT in the array, it will have nil as index_in_ety_array
        # push it in array with its own default color.
        # subsuquent matches will match this color
      elsif index_in_ety_array.nil?

        # set default color to missing. If it later is found, use found_color
        found_color = "ffffff"
        if languages_array.find_index(result[:abbreviation])
          found_color = color_codes_array[languages_array.find_index(result[:abbreviation])]
        end

        # push the etymology, language, and color into the etymology_array
        # the_index = index_in_ety_array ? index_in_ety_array : 0
        etymology_array << { etymology: matching_etymology, languages: [result.abbreviation], color: found_color, family: matching_family }

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

    # filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
    # file_source = filename.read()

    french_color = nil
    english_color = nil
    italian_color = nil
    if !result_array.select { |x| x[:abbreviation] == "it" }.length.zero?
      italian_color = result_array.select { |x| x[:abbreviation] == "it" }[0][:color]
    end
    if !result_array.select { |x| x[:abbreviation] == "en" }.length.zero?
      english_color = result_array.select { |x| x[:abbreviation] == "en" }[0][:color]
    end
    if !result_array.select { |x| x[:abbreviation] == "fr" }.length.zero?
      french_color = result_array.select { |x| x[:abbreviation] == "fr" }[0][:color]
    end
    # italian_color = result_array.select{|x| x[:abbreviation] == "it" } ? [0][:color]
    # english_color = result_array.select{|x| x[:abbreviation] == "en" }[0][:color]
    # french_color = result_array.select{|x| x[:abbreviation] == "fr" }&[0]&[:color]

    # remove unused langs $__ from map and color it blank
    # remove unused regional langs $__ and color it to larger lang
    unused_map_languages = map_languages - current_languages
    for unused_language in unused_map_languages

      # change the text to ""
      map_code = map_code.sub("$" + unused_language, "")

      # find the corresponding color
      color_from_map = color_codes_array[languages_array.find_index(unused_language)]

      # change the color.
      if ["pms", "lij", "vnc", "nap", "scn", "sc"].include?(unused_language) && !italian_color.nil? && italian_color != "ffffff"
        map_code = map_code.gsub("#" + color_from_map, "#" + italian_color)
      elsif unused_language == "sco" && !english_color.nil? && english_color != "ffffff"
        map_code = map_code.gsub("#" + color_from_map, "#" + english_color)
      elsif ["oc", "co", "br"].include?(unused_language) && !french_color.nil? && french_color != "ffffff"
        map_code = map_code.gsub("#" + color_from_map, "#" + french_color)
      else
        map_code = map_code.gsub("#" + color_from_map, "#" + "ffffff")
      end
    end

    # Update the map text and color for exitsting etymologies
    for language in result_array

      # put the result text on the map. => [мідь - midʹ]
      map_code = map_code.sub("$" + language[:abbreviation], "#{language[:translation]}")

      # change the result color on the map
      color_from_map = "ffffff"
      if languages_array.include?(language[:abbreviation])
        color_from_map = color_codes_array[languages_array.find_index(language[:abbreviation])]
      end
      map_code = map_code.gsub("#" + color_from_map, "#" + language[:color])
    end

    map_file.close

    pp etymology_array.sort { |a, b| a[:family] <=> b[:family] }

    unused_search_results = (map_languages - search_results_lang_array).sort
    unused_map_languages2 = (search_results_lang_array - map_languages).sort

    puts "\n"
    puts "#{search_results.length} matching languages in the DB for the word: #{word.upcase} in: #{area}"
    puts "#{map_languages.length} languages on the map"
    puts "#{unused_map_languages.length} unused languages(on map, but not in DB or no etymology)"
    print unused_map_languages
    puts "\n"
    puts "#{unused_search_results.length} unused languages(on map, but not in DB)"
    print unused_search_results
    puts "\n"
    puts "#{unused_map_languages2.length} unused search languages(in search results, but not on map)"
    if unused_map_languages2.length > 0
      print unused_map_languages2
    end
    puts "\n"
    puts "#{current_languages.length} languages in DB and map"
    puts "#{etymology_array.length} <== unique etymologies"
    # puts "#{(My_europe_svg.length - map_languages.length)} languages missing between My_europe_svg and map_languages:"
    # puts "They are: #{My_europe_svg - map_languages} languages"
    puts "\n"
    puts "computed in #{Time.now - t1} seconds."
    puts "\n"

    send_map(map_code)
  end

  def self.send_map(map_code)
    FileUtils.copy_entry("public/my_europe_template.svg", "public/my_europe_template_copy.svg", preserve = false, dereference = false, remove_destination = true)
    the_new_map = open("public/my_europe_template_copy.svg", "w")
    the_new_map.write(map_code)
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
