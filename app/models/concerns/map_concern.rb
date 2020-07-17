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
        # all the current langs. Used to delete missing "$__" from the SVG
        current_languages = []
        # ["ar", "mt", ...]

        # Append romanization if not the same as translation
        # example [nl, water], ["uk", "мідь - midʹ"]
        search_results.each do |result|
          if result.translation == result.romanization
            result_array << ["#{result.abbreviation}", "#{result.translation}"]
          else
            combo = "#{result.translation} - #{result.romanization}"
            result_array << ["#{result.abbreviation}", "#{combo}"]
          end
          current_languages << result.abbreviation
        end

        # finds the languages that are ON the .svg, but not in the results
        unused_map_langs = My_europe_svg-current_languages

        filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
        file_source = filename.read()

        # change the "$__" to "my info"
        for language in result_array
          file_source = file_source.sub("$" + language[0], language[1])
        end
        # change the "$__" to "" to hide missing info.
        for language in unused_map_langs
          file_source = file_source.sub("$" + language, "")
        end

        FileUtils.copy_entry("public/my_europe_template.svg", "public/my_europe_copy_template.svg", preserve = false, dereference = false, remove_destination = true)

        the_new_map = open("public/my_europe_copy_template.svg", "w")

        the_new_map.write(file_source)
        # the_new_map.close()
        the_new_map
        # send_file the_new_map, disposition: :inline
      end

      def self.find_all_genders_by_area_img(area, word)
        search_results = Translation.find_all_translations_by_area(area, word)
        languages_array = Combo.map { |item| item[0] }
        color_codes_array = Combo.map { |item| item[1] }
        result_array = []
        current_languages = []

        # Append romanization if not the same as translation
        # example [nl, water, n], ["uk", "мідь - midʹ, n"]
        # => result_array = [[nl, water, n], ["uk", "мідь - midʹ, n"]... ]
        # => current_languages = ["ar", "mt", "sq", ...]
        search_results.each do |result|
          if result.translation == result.romanization
            result_array << {abbreviation: "#{result.abbreviation}", translation: "#{result.translation}", gender: "#{result.gender}"}
          else
            combo = "#{result.translation} - #{result.romanization}"
            result_array << {abbreviation: "#{result.abbreviation}", translation: "#{combo}", gender: "#{result.gender}"}
          end
          current_languages << result.abbreviation
        end

        unused_map_langs = My_europe_svg-current_languages

        filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
        file_source = filename.read()

        # remove unused "$__" from map
        for language in unused_map_langs
          # file_source = file_source.sub("$" + language, "")
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
          when nil
            result_color = "D3D3D3"
          when ""
            result_color = "D3D3D3"
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
          if languages_array.include?(language[:abbreviation])
            existing_color = color_codes_array[languages_array.find_index(language[:abbreviation])]
          end

          if !existing_color.nil?
            file_source = file_source.gsub("#" + existing_color, "#" + result_color)
          end
        end

        FileUtils.copy_entry("public/my_europe_template.svg", "public/my_europe_copy_template.svg", preserve = false, dereference = false, remove_destination = true)

        the_new_map = open("public/my_europe_copy_template.svg", "w")

        the_new_map.write(file_source)
        # the_new_map.close()
        the_new_map
        
        # send_file the_new_map, disposition: :inline
      end

      def self.find_all_etymologies_by_area_img(area, word)
        search_results = Translation.find_all_translations_by_area(area, word)
        languages_array = Combo.map { |item| item[0] }
        color_codes_array = Combo.map { |item| item[1] }
        result_array = []
        etymology_array = []

        # Append romanization if not the same as translation
        # example [nl, water, shared_ety_number], ["uk", "мідь - midʹ", shared_ety_number]
        search_results.each do |result|
          # if the result.ety is not nil/null
          if !result.etymology.nil? || !result.etymology == "Null"
            current_etymology = result.etymology&.strip
            # if the etymology_array includes the current etymology
            if etymology_array.any? { |ety| ety && ety.include?(current_etymology.to_s) }
              # byebug
            # ety grouper helper method
            # look at the above line in the future
              index = etymology_array.find_index { |ety| ety && ety.include?(current_etymology.to_s) }
              # append romanization optionally
              if result.translation == result.romanization
                result_array << ["#{result.abbreviation}", "#{result.translation}", index.to_i]
              else
                combo = "#{result.translation} - #{result.romanization}"
                result_array << ["#{result.abbreviation}", "#{combo}", index.to_i]
              end
            # if the ety is NOT in the array, push it in.
            # handle romanization
            else
              etymology_array << current_etymology
              if result.translation == result.romanization
                result_array << ["#{result.abbreviation}", "#{result.translation}", etymology_array.length.to_i]
              else
                combo = "#{result.translation} - #{result.romanization}"
                result_array << ["#{result.abbreviation}", "#{combo}", etymology_array.length.to_i]
              end
            end

          # if etymology is null/nil, append nil as number
          # account for non latin translations
          # ["uk", "мідь - midʹ", nil]
          else
            if result.translation == result.romanization
              result_array << ["#{result.abbreviation}", "#{result.translation}", nil]
            else
              combo = "#{result.translation} - #{result.romanization}"
              result_array << ["#{combo}", "#{result.translation}", nil]
            end
          end
        end
        # pp result_array[0]

        filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
        file_source = filename.read()

        counter = 0
        for language in result_array
          # byebug
          puts "#{language}, #{counter}"
          file_source = file_source.sub("$" + language[0], result_array[counter][1])
  
          result_color = ""
          if !result_array[counter][2].nil?
            result_color = color_codes_array[result_array[counter][2]]
          else
            result_color = "d9d9d9"
          end
          col = nil
          if languages_array.include?(language[0])
            col = color_codes_array[languages_array.find_index(language[0])]
          end
          # byebug
          if !col.nil?
            file_source = file_source.gsub("#" + col, "#" + result_color)
          end
          counter += 1
        end


        for language in result_array
          file_source = file_source.sub("$" + language[0], language[1])
        end

        unused_map_langs = My_europe_svg-current_languages

        for language in unused_map_langs
          file_source = file_source.sub("$" + language, "")
        end

        FileUtils.copy_entry("public/my_europe_template.svg", "public/my_europe_copy_template.svg", preserve = false, dereference = false, remove_destination = true)

        the_new_map = open("public/my_europe_copy_template.svg", "w")

        the_new_map.write(file_source)
        # the_new_map.close()
        the_new_map
        # send_file the_new_map, disposition: :inline
      end
    end
  end

  # def self.romanization_helper(result)
  #   if result.translation == result.romanization
  #     result_array << ["#{result.abbreviation}", "#{result.translation}", nil]
  #   else
  #     combo = "#{result.translation} - #{result.romanization}"
  #     result_array << ["#{combo}", "#{result.translation}", nil]
  #   end
  # end

end


 