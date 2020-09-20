module Api::V1
  class LanguagesController < ApplicationController
    before_action :authorized, only: [:show, :edit, :update, :destroy]
    # skip_before_action: authorized, only: [:index]

    def index
      @languages = Language.all.order(:id)
      render json: @languages
    end

    def show
      find_language
      render json: @language
    end

    # def new
    #   @language = Language.new
    # end

    # def create
    #   @language = Language.new(language_params)
    #   if @language.save
    #     message = "Language successfully created"
    #     puts "=> #{message}"
    #     render json: { message: message, success: true, data: @language }, status: 200
    #   else
    #     message = "Language NOT created"
    #     puts "=> #{message}"
    #     puts "Errors= #{@language.errors.full_messages.join(", ")}"
    #     render json: { message: "#{message} because #{@language.errors.full_messages.join(", ")}", success: false, data: @language.errors.full_messages }, status: 406
    #   end
    # end

    def edit
      find_language
    end

    def update
      find_language
      if @language.nil?
        message = "Language NOT found"
        puts "=> #{message}"
        render json: { message: message, success: false }, status: 406
      end
      if @language.update(language_params)
        message = "Language successfully updated"
        puts "=> #{message}"
        render json: { message: message, success: true, data: @language }, status: 200
      else
        message = "Language NOT updated"
        puts "=> #{message}"
        puts "Errors= #{@language.errors.full_messages.join(", ")}"
        render json: { message: "#{message} because #{@language.errors.full_messages.join(", ")}", success: false, data: @language.errors.full_messages }, status: 406
      end
    end

    def destroy
      find_language
      if @language.destroy
        message = "Language successfully destroyed"
        puts "=> #{message}"
        render json: { message: message, success: true, data: @language }, status: 200
      else
        message = "Language NOT destroyed"
        puts "=> #{message}"
        puts "Error in delete: #{@language.errors.full_messages.join(", ")}"
        render json: { message: "#{message} because #{@language.errors.full_messages.join(", ")}", success: false, data: @language.errors.full_messages.join(", ") }, status: 406
      end
    end

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    def all_macrofamily_names
      @macrofamilies = Language.all_macrofamily_names
      render json: { message: "All Macrofamiliy names successfully returned.", success: true, data: @macrofamilies }, status: 200
    end

    def all_alphabet_names
      @alphabets = Language.all_alphabet_names
      render json: { message: "All Alphabet names successfully returned.", success: true, data: @alphabets }, status: 200
    end

    def all_area_names
      @areas = Language.all_area_names
      render json: { message: "All Language area names successfully returned.", success: true, data: @areas }, status: 200
    end

    def find_all_languages_by_area
      @languages = Language.find_all_languages_by_area(params[:area])
      render json: { message: "All Languages in #{params[:area]} successfully returned.", success: true, data: @languages }, status: 200
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
