module MapConcern
  module ClassMethods
    extend ActiveSupport::Concern
    included do
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
      My_europe_svg = ["ab", "ar", "az", "be", "bg", "br", "ca", "co", "cs", "cy", "da", "de", "el", "en", "es", "et", "eu", "fi", "fo", "fr", "fy", "ga", "gag", "gd", "gl", "hu", "hy", "is", "it", "ka", "kk", "krl", "lb", "lij", "lt", "lv", "mk", "mt", "nap", "nl", "no", "oc", "os", "pl", "pms", "pt", "rm", "ro", "ru", "sc", "scn", "sco", "se", "sh", "sh", "sh", "sk", "sl", "sq", "tk", "tt", "uk", "vnc", "xal"]

      def self.find_all_translations_by_area_img(area, word)
        # get the relevant info from the DB
        search_results = Translation.find_all_translations_by_area(area, word)
        # result after processing
        result_array = []
        # all the current langs. Used to find & delete missing "$__" from the SVG
        current_languages = []
        # ["ar", "mt", ...]

        # Append romanization if not the same as translation
        # example [nl, water], ["uk", "мідь - midʹ"]
        search_results.each do |result|
          if result.translation == result.romanization
            result_array << {abbreviation: "#{result.abbreviation}", translation: "#{result.translation}"}
          else
            combo = "#{result.translation} - #{result.romanization}"
            result_array << {abbreviation: "#{result.abbreviation}", translation: combo }
          end
          current_languages << result.abbreviation
        end

        filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
        file_source = filename.read()

        # change the "$__" to "my info"
        for language in result_array
          file_source = file_source.sub("$" + language[:abbreviation], language[:translation])
        end

        # change the "$__" to "" to hide missing info.
        # finds the languages that are ON the .svg, but not in the results
        unused_map_langs = My_europe_svg-current_languages
        for language in unused_map_langs
          file_source = file_source.sub("$" + language, "")
        end

        send_map(file_source)
      end

      def self.find_all_genders_by_area_img(area, word)
        search_results = Translation.find_all_translations_by_area(area, word)
        languages_array = Combo.map { |item| item[0] }
        color_codes_array = Combo.map { |item| item[1] }
        result_array = []
         # => result_array = [[nl, water, n], ["uk", "мідь - midʹ, n"]... ]
        current_languages = []
        # =>  ["ar", "mt", "sq", ...]

        # Append romanization if not the same as translation
        # example [nl, water, n], ["uk", "мідь - midʹ, n"]
        search_results.each do |result|
          if result.translation == result.romanization
            result_array << {abbreviation: "#{result.abbreviation}", translation: "#{result.translation}", gender: "#{result.gender}"}
          else
            combo = "#{result.translation} - #{result.romanization}"
            result_array << {abbreviation: "#{result.abbreviation}", translation: "#{combo}", gender: "#{result.gender}"}
          end
          current_languages << result.abbreviation
        end

        filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
        file_source = filename.read()

        # remove unused "$__" from map and give gray color
        unused_map_langs = My_europe_svg-current_languages
        for language in unused_map_langs
          if languages_array.include?(language)
            existing_color = color_codes_array[languages_array.find_index(language)]
          end
          if !existing_color.nil?
            file_source = file_source.gsub("#" + existing_color, "#D3D3D3")
            file_source = file_source.sub("$" + language, "")
          end
        end

        # Change "$__" to something
        for language in result_array
          file_source = file_source.sub("$" + language[:abbreviation], language[:translation])

          result_color = ""
          case language[:gender]
          # when nil
          #   result_color = "D3D3D3"
          # when ""
          #   result_color = "D3D3D3"
          when "m"
            result_color = "00BFFF"
          when "f"
            result_color = "FF1493"
          when "n"
            result_color = "778899"
          when "n inan"
            result_color = "778899"
          else
            result_color = "D3D3D3"
          end
          existing_color = nil

          # if the current language is on the map, find its corresponding color
          if languages_array.include?(language[:abbreviation])
            existing_color = color_codes_array[languages_array.find_index(language[:abbreviation])]
          end

          # change the existing color to the result_color
          if !existing_color.nil?
            file_source = file_source.gsub("#" + existing_color, "#" + result_color)
          end
        end

        send_map(file_source)
      end

      def self.find_all_etymologies_by_area_img(area, word)
        search_results = Translation.find_all_translations_by_area(area, word)
        languages_array = Combo.map { |item| item[0] }
        color_codes_array = Combo.map { |item| item[1] }
        result_array = []
        etymology_array = []
        current_languages = []

        # Append romanization if not the same as translation
        # example [nl, water, shared_ety_number], ["uk", "мідь - midʹ", shared_ety_number]
        array_counter = 0
        search_results.each do |result|
          # if the result.ety is not nil/null, strip it
          if !result.etymology.nil? || !result.etymology == "Null"
            current_etymology = result.etymology&.strip
            # it the current_etymology IS in the etymology_array, append its index to the result_array
            if etymology_array.any? { |item| item && item[:etymology].include?(current_etymology.to_s) }
            # INSERT ety grouper helper method here
            # look at the above line in the future. Combine with below one.
              found_index = etymology_array.find_index { |item| item && item[:etymology].include?(current_etymology.to_s) }
              etymology_array[found_index][:languages] << result.abbreviation
              # found_color = color_codes_array[languages_array.find_index(result[:abbreviation])]
              found_color = etymology_array[found_index][:color]
              # append romanization optionally
              if result.translation == result.romanization
                result_array << {abbreviation: "#{result.abbreviation}", translation: "#{result.translation}", index: found_index.to_i, color: found_color }
              else
                combo = "#{result.translation} - #{result.romanization}"
                result_array << {abbreviation: "#{result.abbreviation}", translation: "#{combo}", index: found_index.to_i, color: found_color }
              end
            # if the ety is NOT in the array, push it in. and give the result number the next number in the array
            # handle romanization
            else
              found_color = nil
              if languages_array.find_index(result[:abbreviation])
                found_color = color_codes_array[languages_array.find_index(result[:abbreviation])] 
              else
                found_color = "d9d9d9"
              end
              etymology_array << {etymology: current_etymology, languages: [result.abbreviation], color: found_color }
              if result.translation == result.romanization
                result_array << {abbreviation: "#{result.abbreviation}", translation: "#{result.translation}", index: array_counter, color: found_color }
              else
                combo = "#{result.translation} - #{result.romanization}"
                result_array << {abbreviation: "#{result.abbreviation}", translation: "#{combo}", index: array_counter, color: found_color }
              end
              array_counter += 1
            end

          # if etymology IS null/nil, append nil as the number
          # account for non latin translations
          # ["uk", "мідь - midʹ", nil]
          else
            if result.translation == result.romanization
              result_array << {abbreviation: "#{result.abbreviation}", translation: "#{result.translation}", index: nil, color: "d9d9d9" }
            else
              combo = "#{result.translation} - #{result.romanization}"
              result_array << {abbreviation: "#{result.abbreviation}", translation: "#{combo}", index: nil, color: "d9d9d9" }
            end
          end
          current_languages << result.abbreviation
        end
        pp etymology_array
        # pp result_array[0]

        filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
        file_source = filename.read()

        # remove unused langs
        unused_map_langs = My_europe_svg-current_languages
        for language in unused_map_langs
          # color_from_map = color_codes_array[languages_array.find_index(language[:abbreviation])]
          file_source = file_source.sub("$" + language, "")
          # file_source = file_source.gsub("#" + color_from_map, "#d9d9d9" )
        end

        # change the text on the map
        # for language in result_array
        #   file_source = file_source.sub("$" + language[0], language[1])
        # end

        # change text on map
        # change color on map
        counter = 0
        for language in result_array
          puts "#{language}, #{counter}"

          # put the answer on the img. => [мідь - midʹ - 5]
          file_source = file_source.sub("$" + language[:abbreviation], "#{language[:translation]} - #{language[:index]}")
     
          # result_color = nil
          # if !language[:index].nil?
          #   result_color = color_codes_array[language[:index]]
          # else
          #   result_color = "d9d9d9"
          # end
          color_from_map = nil
          if languages_array.include?(language[:abbreviation])
            color_from_map = color_codes_array[languages_array.find_index(language[:abbreviation])]
          else
            color_from_map = "d9d9d9"
          end
          if !color_from_map.nil?
            # file_source = file_source.gsub("#" + color_from_map, "#" + result_color)
            file_source = file_source.gsub("#" + color_from_map, "#" + language[:color] )
          end
          counter += 1
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
    
      # def self.ety_helper
      # end

    end
  end

end


 