module MapConcern
  module ClassMethods
    extend ActiveSupport::Concern
    included do
      Combo = [
        ["ab", "168d4f"],
        ["ar", "ffffb1"],
        ["az", "d45500"],
        ["be", "b5ff64"],
        ["bos", "abc837"],
        ["br", "178df0"],
        ["bg", "36ae22"],
        ["ca", "00ffff"],
        ["cau", "d38d5f"],
        ["cs", "00cb60"],
        ["co", "c0003c"],
        ["cy", "ff7f29"],
        ["da", "ff5555"],
        ["de", "d09999"],
        ["el", "ffff00"],
        ["en", "ffaaaa"],
        ["et", "b7c8be"],
        ["eu", "ffd42a"],
        ["fo", "ff0000"],
        ["fi", "6f997a"],
        ["fr", "53bbb5"],
        ["fy", "d66c74"],
        ["ga", "fd6d3c"],
        ["gd", "ff7f2a"],
        ["gl", "00d4aa"],
        ["gag", "c837ab"],
        ["hr", "abc837"],
        ["hu", "ac9d93"],
        ["hy", "008080"],
        ["is", "f19076"],
        ["it", "7bafe0"],
        ["ka", "f4e3d7"],
        ["kk", "deaa87"],
        ["krl", "93ac93"],
        ["lv", "de87cd"],
        ["lt", "e9afdd"],
        ["lij", "f2003c"],
        ["lb", "55ddff"],
        ["mk", "71c837"],
        ["mt", "a0892c"],
        ["nap", "f5003c"],
        ["nl", "f4d7d7"],
        ["no", "ff8080"],
        ["oc", "168d5f"],
        ["os", "985fd3"],
        ["pms", "f2d53c"],
        ["pl", "7ecb60"],
        ["pt", "00d4d4"],
        ["rm", "008079"],
        ["ro", "aaccff"],
        ["ru", "72ff00"],
        ["sc", "c0ee3c"],
        ["sco", "168df0"],
        ["scn", "cc003c"],
        ["sk", "42f460"],
        ["sl", "81c98d"],
        ["se", "cccccc"],
        ["es", "acd8ed"],
        ["sq", "a0856c"],
        ["srp", "abc837"],
        ["sv", "ffb380"],
        ["tt", "c7a25f"],
        ["tk", "cc9e4c"],
        ["uk", "c1ff00"],
        ["ven", "f28d3c"],
        ["xal", "d34d5f"],
        ["sh", "abc837"],
      ]

      def self.find_all_translations_by_area_img(area, word)
        search_results = Translation.find_all_translations_by_area(area, word)
        languages_array = Combo.map { |item| item[0] }
        result_array = []

        # Append romanization if not the same as translation
        # example [nl, water], ["uk", "мідь - midʹ"]
        search_results.each do |result|
          if result.translation == result.romanization
            result_array << ["#{result.abbreviation}", "#{result.translation}"]
          else
            combo = "#{result.translation} - #{result.romanization}"
            result_array << ["#{result.abbreviation}", "#{combo}"]
          end
        end
        pp result_array[0]

        filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
        file_source = filename.read()
        for language in result_array
          file_source = file_source.sub("$" + language[0], language[1])
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

        # Append romanization if not the same as translation
        # example [nl, water, n], ["uk", "мідь - midʹ, n"]
        search_results.each do |result|
          if result.translation == result.romanization
            result_array << {abbreviation: "#{result.abbreviation}", translation: "#{result.translation}", gender: "#{result.gender}"}
          else
            combo = "#{result.translation} - #{result.romanization}"
            result_array << {abbreviation: "#{result.abbreviation}", translation: "#{combo}", gender: "#{result.gender}"}
          end
        end
        # pp result_array

        # filename = File.open("public/my_europe_template.svg", "r")
        filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
        file_source = filename.read()

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

      def self.find_all_etymologies_by_area_img
        search_results = Translation.find_all_translations_by_area(area, word)
        languages_array = Combo.map { |item| item[0] }
        color_codes_array = Combo.map { |item| item[1] }
        result_array = []

        # Append romanization if not the same as translation
        # example [nl, water, shared_ety_number], ["uk", "мідь - midʹ", shared_ety_number]
        search_results.each do |result|
          # byebug
          if !result.etymology.nil? || !result.etymology == "Null"
            etymology = result.etymology&.strip
            if etymology_array.any? { |ety| ety && ety.include?(etymology.to_s) }
              index = etymology_array.find_index { |ety| ety && ety.include?(etymology.to_s) }
              if result.translation == result.romanization
                result_array << ["#{result.abbreviation}", "#{result.translation}", index.to_i]
              else
                combo = "#{result.translation} - #{result.romanization}"
                result_array << ["#{result.abbreviation}", "#{combo}", index.to_i]
              end
            else
              etymology_array << etymology
              if result.translation == result.romanization
                result_array << ["#{result.abbreviation}", "#{result.translation}", etymology_array.length.to_i]
              else
                combo = "#{result.translation} - #{result.romanization}"
                result_array << ["#{result.abbreviation}", "#{combo}", etymology_array.length.to_i]
              end
            end
          else
            if result.translation == result.romanization
              result_array << ["#{result.abbreviation}", "#{result.translation}", nil]
            else
              combo = "#{result.translation} - #{result.romanization}"
              result_array << ["#{combo}", "#{result.translation}", nil]
            end
          end
        end
        byebug
        pp result_array[0]

        filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
        file_source = filename.read()
        for language in result_array
          file_source = file_source.sub("$" + language[0], language[1])
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
end


 