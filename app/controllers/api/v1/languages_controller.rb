module Api::V1
  class LanguagesController < ApplicationController

    def index 
      @languages = Language.all
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
        puts "=> language saved"
        render json: { message: "Language successfully saved.", success: true, data: @language }, status: 200
      else
        puts "Language not saved"
        puts "Errors= #{@language.errors.full_messages.join(", ")}"
        render json: { message: "Language NOT saved because #{@language.errors.full_messages.join(", ")}", success: false, data: @language.errors.full_messages }, status: 406
      end
    end

    def edit
    end

    def update
      if @language.nil?
        puts "Language not found"
        render json: { message: "Language not found", success: false }, status: 406
      end
      if @language.update(language_params)
        puts "Language updated"
        render json: { message: "Language successfully saved.", success: true, data: @language }, status: 200
      else
        puts "Language not saved"
        puts "Errors= #{@language.errors.full_messages.join(", ")}"
        render json: { message: "Language NOT updated because #{@language.errors.full_messages.join(", ")}", success: false, data: @language.errors.full_messages }, status: 406
      end
    end

      def destroy
        if @language.destroy
          render json: { message: "Language successfully deleted.", success: true, data: @language }, status: 200
        else
          render json: { message: "Language NOT successfully deleted.", success:false, data: @language.errors.full_messages.join(", ") }, status: 406
          puts "Error in delete: #{@language.errors.full_messages.join(", ")}"
        end
      end

    private

      def find_language
        @languages = Language.find(params[:id])
      end

      def language_params
        params.require(:language).permit(:name, :abbreviation, :alphabet, :macrofamily, :family, :subfamily, :area, :area2, :notes, :alive)
      end

  end
end