module Api::V1
  class WordsController < ApplicationController

    def index 
      @words = Word.all
      render json: @words
    end

    def show
      find_word
      render json: @word
    end

    def new
    end

    def create
      @word = Word.new(word_params)
      if @word.save
        puts "=> Word saved"
        render json: { message: "Word successfully saved.", success: true, data: @translation }, status: 200
      else
        puts "Word not saved"
        puts "Errors= #{@word.errors.full_messages.join(", ")}"
        render json: { message: "Word NOT saved because #{@word.errors.full_messages.join(", ")}", success: false, data: @word.errors.full_messages }, status: 406
      end
    end

    def edit
      find_word
    end

    def update
      find_word
      if @translation.nil?
        puts "Word not found"
        render json: { message: "Word not found", success: false }, status: 406
      end
      if @translation.update(translation_params)
        puts "Word updated"
        render json: { message: "Word successfully saved.", success: true, data: @word }, status: 200
      else
        puts "Word not saved"
        puts "Errors= #{@word.errors.full_messages.join(", ")}"
        render json: { message: "Word NOT updated because #{@word.errors.full_messages.join(", ")}", success: false, data: @word.errors.full_messages }, status: 406
      end
    end

    def destroy
      find_word
      if @word.destroy
        render json: { message: "Word successfully deleted.", success: true, data: @word }, status: 200
      else
        render json: { message: "Word NOT successfully deleted.", success:false, data: @word.errors.full_messages.join(", ") }, status: 406
        puts "Error in delete: #{@word.errors.full_messages.join(", ")}"
      end
    end

    private

      def find_word
        @word = Word.find(params[:id])
      end

      def word_params
        params.require(:word).permit(:name)
      end
      
  end
end