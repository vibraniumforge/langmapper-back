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
        render json: { message: "Translation NOT successfully deleted.", success:false, data: @translation.errors.full_messages.join(", ") }, status: 406
        puts "Error in delete: #{@translation.errors.full_messages.join(", ")}"
      end
    end

    def find_all_translations
      @translations = Translation.find_all_translations(params[:word])
      render json: @translations
    end

    def find_all_genders
      @genders = Translation.find_all_genders(params[:word])
      render json: @genders
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