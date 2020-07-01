module Api::V1
  class LanguagesController < ApplicationController
    def index
      @languages = Language.all.order(:id)
      render json: @languages
    end

    def show
      find_language
      render json: @language
    end

    def new
      @language = Language.new
    end

    def create
      @language = Language.new(language_params)
      if @language.save
        puts "=> language created"
        render json: { message: "Language successfully created.", success: true, data: @language }, status: 200
      else
        puts "Language not created"
        puts "Errors= #{@language.errors.full_messages.join(", ")}"
        render json: { message: "Language NOT created because #{@language.errors.full_messages.join(", ")}", success: false, data: @language.errors.full_messages }, status: 406
      end
    end

    def edit
      find_language
    end

    def update
      find_language
      if @language.nil?
        puts "Language not found"
        render json: { message: "Language not found", success: false }, status: 406
      end
      if @language.update(language_params)
        puts "=> language updated"
        render json: { message: "Language successfully updated.", success: true, data: @language }, status: 200
      else
        puts "Language not updated"
        puts "Errors= #{@language.errors.full_messages.join(", ")}"
        render json: { message: "Language NOT updated because #{@language.errors.full_messages.join(", ")}", success: false, data: @language.errors.full_messages }, status: 406
      end
    end

    def destroy
      find_language
      if @language.destroy
        render json: { message: "Language successfully deleted.", success: true, data: @language }, status: 200
      else
        render json: { message: "Language NOT successfully deleted.", success: false, data: @language.errors.full_messages.join(", ") }, status: 406
        puts "Error in delete: #{@language.errors.full_messages.join(", ")}"
      end
    end

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    def find_all_macrofamily_names
      @macrofamilies = Language.find_all_macrofamily_names
      render json: { message: "All Macrofamiliy names successfully returned.", success: true, data: @macrofamilies }, status: 200
    end

    def find_all_alphabet_names
      @alphabets = Language.find_all_alphabet_names
      render json: { message: "All Alphabet names successfully returned.", success: true, data: @alphabets }, status: 200
    end

    def find_all_area_names
      @areas = Language.find_all_area_names
      render json: { message: "All Language area names successfully returned.", success: true, data: @areas }, status: 200
    end

    def find_all_languages_by_area
      @languages = Language.find_all_languages_by_area(params[:area])
      render json: { message: "All Languages successfully returned.", success: true, data: @languages }, status: 200
    end

    def languages_count
      @languages = Language.languages_count
      render json: { message: "Languages count successfully returned.", success: true, data: @languages }, status: 200
    end

    private

    def find_language
      @language = Language.find(params[:id])
    end

    def language_params
      params.require(:language).permit(:name, :abbreviation, :alphabet, :macrofamily, :family, :subfamily, :area1, :area2, :area3, :notes, :alive)
    end
  end
end
