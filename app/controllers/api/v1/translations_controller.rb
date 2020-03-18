module Api::V1
  class TranslationsController < ApplicationController
    def index
      @translations = Translation.all
      render json: @translations
    end

    def show
      find_translation
      render json: @translation
    end

    def new
      @language = Translation.new
    end

    def create
      @translation = Translation.new(translation_params)
      if @translation.save
        puts "=> translation saved"
        render json: { message: "Translation successfully saved.", success: true, data: @translation }, status: 200
      else
        puts "Translation not saved"
        puts "Errors= #{@translation.errors.full_messages.join(", ")}"
        render json: { message: "Translation NOT saved because #{@translation.errors.full_messages.join(", ")}", success: false, data: @translation.errors.full_messages }, status: 406
      end
    end

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
        render json: { message: "Translation successfully saved.", success: true, data: @translation }, status: 200
      else
        puts "Translation not saved"
        puts "Errors= #{@translation.errors.full_messages.join(", ")}"
        render json: { message: "Language NOT updated because #{@translation.errors.full_messages.join(", ")}", success: false, data: @translation.errors.full_messages }, status: 406
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

    def find_all_translations
      @translations = Translation.find_all_translations(params[:word])
      render json: @translations
    end

    def find_all_genders
      @genders = Translation.find_all_genders(params[:word])
      render json: @genders
    end

    def find_etymology_containing
      @etymologies = Translation.ety_query(params[:word])
      render json: @etymologies
    end

    def find_grouped_etymologies
      @etymologies = Translation.find_grouped_etymologies(params[:word], params[:macrofamily])
      render json: @etymologies
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
      @translations = Translation.find_all_translations_by_language(params[:language])
      render json: { message: "Translations by language successfully returned.", success: true, data: @translations }, status: 200
    end

    def find_all_translations_by_area
      @translations = Translation.find_all_translations_by_area(params[:location], params[:word])
      render json: { message: "Translations by area successfully returned.", success: true, data: @translations }, status: 200
    end

    def translation_count
      @translations = Translation.count
      render json: { message: "Translations count successfully returned.", success: true, data: @translations }, status: 200
    end

    def find_all_translations_by_area_img
      # @translations = Translation.find_all_translations_by_area_img(params[:location], params[:word])
      # render json: { message: "Translations count successfully returned.", success: true, data: @translations }, status: 200

      result_array = Translation.find_all_translations_by_area_img(params[:location], params[:word])
      filename = File.open("public/europe_template.svg", "r")
      file_source = filename.read()

      color_array = ["red", "orange", "yellow", "green", "blue", "purple"]

      counter = 0
      for language in result_array
        puts "#{language}, #{counter}"
        file_source = file_source.sub("$" + language[0], result_array[counter][1])
        color_index = counter % color_array.length
        result_color = color_array[result_array[color_index][2]]
        color = result_array[counter][2]
        # file_source = file_source.sub("#" + color, result_color)
        counter += 1
      end
      
      FileUtils.copy_entry("public/europe_template.svg", "public/europe_copy_template.svg", preserve = false, dereference = false, remove_destination = true)

      the_new_map = open("public/europe_copy_template.svg", "w")

      the_new_map.write(file_source)
      # the_new_map.close()

      send_file the_new_map, disposition: :inline
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
