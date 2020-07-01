module Api::V1
  class TranslationsController < ApplicationController
    require "open-uri"

    def index
      @translations = Translation.all
      render json: @translations
    end

    def show
      find_translation
      render json: @translation
    end

    # def new
    #   @language = Translation.new
    # end

    # def create
    #   @translation = Translation.new(translation_params)
    #   if @translation.save
    #     puts "=> translation created"
    #     render json: { message: "Translation successfully created.", success: true, data: @translation }, status: 200
    #   else
    #     puts "Translation not created"
    #     puts "Errors= #{@translation.errors.full_messages.join(", ")}"
    #     render json: { message: "Translation NOT created because #{@translation.errors.full_messages.join(", ")}", success: false, data: @translation.errors.full_messages }, status: 406
    #   end
    # end

    def edit
      find_translation
    end

    def update
      find_translation
      if @translation.nil?
        puts "Translation not found"
        render json: { message: "Translation not found", success: false }, status: 406
      end
      if @translation.update(translation_params)
        puts "Translation updated"
        render json: { message: "Translation successfully updated.", success: true, data: @translation }, status: 200
      else
        puts "Translation not saved"
        puts "Errors= #{@translation.errors.full_messages.join(", ")}"
        render json: { message: "Translation NOT updated because #{@translation.errors.full_messages.join(", ")}", success: false, data: @translation.errors.full_messages }, status: 406
      end
    end

    def destroy
      find_translation
      if @translation.destroy
        render json: { message: "Translation successfully deleted.", success: true, data: @translation }, status: 200
      else
        render json: { message: "Translation NOT successfully deleted.", success: false, data: @translation.errors.full_messages.join(", ") }, status: 406
        puts "Error in delete: #{@translation.errors.full_messages.join(", ")}"
      end
    end

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    def search_all_translations_by_word
      @translations = Translation.search_all_translations_by_word(params[:word])
      render json: 
      { message: "Translations by word successfully returned.", success: true, data: @translations }, status: 200
      # render json: { message: "Translations of #{params[:word]} successfully returned.", success: true, data: @translations}, status: 200
    end

    def find_all_genders
      @genders = Translation.find_all_genders(params[:word])
      # render json: @genders
      render json: { message: "Genders of #{params[:word]} successfully returned.", success: true, data: @genders}, status: 200
    end

    def find_etymology_containing
      @etymologies = Translation.find_etymology_containing(params[:word])
      # render json: @etymologies
      render json: { message: "Etymology containing #{params[:word]} successfully returned.", success: true, data: @etymologies}, status: 200
    end

    def find_grouped_etymologies
      @etymologies = Translation.find_grouped_etymologies(params[:word], params[:macrofamily])
      render json: { message: "Grouped etymologies successfully returned.", success: true, data: @etymologies }, status: 200
    end

    def find_all_translations_by_macrofamily
      @translations = Translation.find_all_translations_by_macrofamily(params[:macrofamily])
      render json: { message: "Translations by macrofamily successfully returned.", success: true, data: @translations }, status: 200
    end

    def all_languages_by_macrofamily
      @macrofamilies = Translation.find_all_translations_by_macrofamily(macrofamily: params[:macrofamily])
      render json: { message: "All macrofamilies successfully returned.", success: true, data: @macrofamilies }, status: 200
    end

    def find_all_translations_by_language
      @translations = Translation.find_all_translations_by_language(params[:language].split("-").map(&:titleize).join("-"))
      render json: { message: "Translations by language successfully returned.", success: true, data: @translations }, status: 200
    end

    def translations_count
      @translations = Translation.count
      render json: { message: "Translations count successfully returned.", success: true, data: @translations }, status: 200
    end

    # Map Makers 6

    def find_all_translations_by_area
      @translations = Translation.find_all_translations_by_area(params[:location], params[:word])
      render json: { message: "Translations by area successfully returned.", success: true, data: @translations }, status: 200
    end

    # dont need these 2 below yet.

    # def find_all_etymologies_by_area
    #   @translations = Translation.find_all_etymologies_by_area(params[:location], params[:word])
    #   render json: { message: "Translations by area successfully returned.", success: true, data: @translations }, status: 200
    # end

    # def find_all_genders_by_area
    #   @translations = Translation.find_all_genders_by_area(params[:location], params[:word])
    #   render json: { message: "Translations by area successfully returned.", success: true, data: @translations }, status: 200
    # end

    def find_all_translations_by_area_img
      # @translations = Translation.find_all_translations_by_area_img(params[:location], params[:word])
      # render json: { message: "Translations count successfully returned.", success: true, data: @translations }, status: 200

      combo = [
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

      languages_array = combo.map { |item| item[0] }
      color_codes_array = combo.map { |item| item[1] }

      result_array = Translation.find_all_translations_by_area_img(params[:location], params[:word])
      # filename = File.open("public/my_europe_template.svg", "r")

      filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
      file_source = filename.read()

      counter = 0
      for language in result_array
        # puts "#{language}, #{counter}"
        file_source = file_source.sub("$" + language[0], result_array[counter][1])
        counter += 1
      end

      FileUtils.copy_entry("public/my_europe_template.svg", "public/my_europe_copy_template.svg", preserve = false, dereference = false, remove_destination = true)

      the_new_map = open("public/my_europe_copy_template.svg", "w")

      the_new_map.write(file_source)
      # the_new_map.close()

      send_file the_new_map, disposition: :inline
    end

    def find_all_etymologies_by_area_img
      # @translations = Translation.find_all_translations_by_area_img(params[:location], params[:word])
      # render json: { message: "Translations count successfully returned.", success: true, data: @translations }, status: 200

      combo = [
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

      languages_array = combo.map { |item| item[0] }
      color_codes_array = combo.map { |item| item[1] }

      result_array = Translation.find_all_etymologies_by_area_img(params[:location], params[:word])
      filename = File.open("public/my_europe_template.svg", "r")
      # filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
      file_source = filename.read()

      counter = 0
      for language in result_array
        # puts "#{language}, #{counter}"
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

      FileUtils.copy_entry("public/my_europe_template.svg", "public/my_europe_copy_template.svg", preserve = false, dereference = false, remove_destination = true)

      the_new_map = open("public/my_europe_copy_template.svg", "w")

      the_new_map.write(file_source)
      # the_new_map.close()

      send_file the_new_map, disposition: :inline
    end

    def find_all_genders_by_area_img

      #  @translations = Translation.find_all_translations_by_area_img(params[:location], params[:word])
      #   render json: { message: "Translations count successfully returned.", success: true, data: @translations }, status: 200

      combo = [
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

      languages_array = combo.map { |item| item[0] }
      color_codes_array = combo.map { |item| item[1] }

      result_array = Translation.find_all_genders_by_area_img(params[:location], params[:word])

      # filename = File.open("public/my_europe_template.svg", "r")
      filename = open("#{Rails.root.to_s}/public/my_europe_template.svg", "r")
      file_source = filename.read()

      counter = 0
      for language in result_array
        # puts "#{language}, #{counter}"
        file_source = file_source.sub("$" + language[:abbreviation], result_array[counter][:translation])

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
        counter += 1
      end

      FileUtils.copy_entry("public/my_europe_template.svg", "public/my_europe_copy_template.svg", preserve = false, dereference = false, remove_destination = true)

      the_new_map = open("public/my_europe_copy_template.svg", "w")

      the_new_map.write(file_source)
      # the_new_map.close()

      send_file the_new_map, disposition: :attachment
      # send_file the_new_map, disposition: :inline
    end

    private

    def find_translation
      @translation = Translation.find(params[:id])
    end

    def translation_params
      params.require(:translation).permit(:translation, :romanization, :link, :gender, :etymology)
    end
  end
end
