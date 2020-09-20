module Api::V1
  class TranslationsController < ApplicationController
    before_action :authorized, only: [:show, :edit, :update, :destroy]
    # skip_before_action: authorized, only: [:index, :new, :create]

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
    #     message = "Translation successfully created."
    #     puts "=> #{message}"
    #     render json: { message: message, success: true, data: @translation }, status: 200
    #   else
    #     message = "Translation NOT created"
    #     puts "=> #{message}"
    #     puts "Errors= #{@translation.errors.full_messages.join(", ")}"
    #     render json: { message: "#{message} because #{@translation.errors.full_messages.join(", ")}", success: false, data: @translation.errors.full_messages }, status: 406
    #   end
    # end

    def edit
      find_translation
    end

    def update
      find_translation
      if @translation.nil?
        message = "Translation NOT found"
        puts "=> #{message}"
        render json: { message: message, success: false }, status: 406
      end
      if @translation.update(translation_params)
        message = "Translation updated"
        puts "=> #{message}"
        render json: { message: message, success: true, data: @translation }, status: 200
      else
        message = "Translation NOT updated"
        puts "=> #{message}"
        puts "Errors= #{@translation.errors.full_messages.join(", ")}"
        render json: { message: "#{message} because #{@translation.errors.full_messages.join(", ")}", success: false, data: @translation.errors.full_messages }, status: 406
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

    def seeds
      @translations = Translation.seeds
      render json: @translations, each_serializer: TranslationSeedSerializer
    end

    def find_all_translations_by_word
      @translations = Translation.find_all_translations_by_word(params[:word])
      render json: { message: "Translations of #{params[:word]} successfully returned.", success: true, data: @translations }, status: 200
    end

    def find_all_translations_by_word_gender
      @translations = Translation.find_all_translations_by_word_gender(params[:word])
      render json: { message: "Genders of #{params[:word]} successfully returned.", success: true, data: @translations }, status: 200
    end

    def find_etymology_containing
      @etymologies = Translation.find_etymology_containing(params[:word])
      render json: { message: "Etymologies containing #{params[:word]} successfully returned.", success: true, data: @etymologies }, status: 200
    end

    def find_all_translations_by_macrofamily
      @translations = Translation.find_all_translations_by_macrofamily(params[:macrofamily])
      render json: { message: "All Translations by macrofamily #{params[:macrofamily]} successfully returned.", success: true, data: @translations }, status: 200
    end

    def find_all_translations_by_language
      @translations = Translation.find_all_translations_by_language(params[:language].split("-").map(&:titleize).join("-"))
      render json: { message: "All Translations in #{params[:language]} successfully returned.", success: true, data: @translations }, status: 200
    end

    def find_all_translations_by_area
      @translations = Translation.find_all_translations_by_area(params[:area], params[:word])
      render json: { message: "All Translations of #{params[:word]} in #{params[:area]} successfully returned.", success: true, data: @translations }, status: 200
    end

    def translations_count
      @translations = Translation.count
      render json: { message: "Translations count successfully returned.", success: true, data: @translations }, status: 200
    end

    def find_all_translations_by_area_europe_map
      @translations = Translation.find_all_translations_by_area_europe_map(params[:area], params[:word])
      # @translations = CreateMapService.find_all_translations_by_area_img(params[:area], params[:word])
      # @translations = Translation.find_all_translations_by_area_img(params[:area], params[:word])
      render json: { message: "Translations of #{params[:word]} in #{params[:area]} successfully returned.", success: true, data: @translations }, status: 200
    end

    # Mappers

    def find_all_translations_by_area_img
      @translations = CreateMapService.find_all_translations_by_area_img(params[:area], params[:word])
      # @translations = Translation.find_all_translations_by_area_img(params[:area], params[:word])
      send_file @translations, disposition: :inline
      # render json: { message: "Translations by area image successfully returned.", success: true, data: @translations, disposition: :inline }, status: 200
    end

    def find_all_genders_by_area_img
      @translations = CreateMapService.find_all_genders_by_area_img(params[:area], params[:word])
      send_file @translations, disposition: :inline
      # render json: { message: "Translations by gender image successfully returned.", success: true, data: @translations }, status: 200
    end

    def find_all_etymologies_by_area_img
      @translations = CreateEtymologyMapService.find_all_etymologies_by_area_img(params[:area], params[:word])
      send_file @translations, disposition: :inline
      # render json: { message: "Translations by etymology image successfully returned.", success: true, data: @translations }, status: 200
    end

    # def find_grouped_etymologies
    # @etymologies = Translation.find_grouped_etymologies(params[:word], params[:macrofamily])
    # render json: { message: "Grouped etymologies successfully returned.", success: true, data: @etymologies }, status: 200
    # end

    # def all_languages_by_macrofamily
    # @macrofamilies = Translation.find_all_translations_by_macrofamily(macrofamily: params[:macrofamily])
    # render json: { message: "All macrofamilies successfully returned.", success: true, data: @macrofamilies }, status: 200
    # end

    private

    def find_translation
      @translation = Translation.find(params[:id])
    end

    def translation_params
      params.require(:translation).permit(:translation, :romanization, :link, :gender, :etymology)
    end
  end
end
