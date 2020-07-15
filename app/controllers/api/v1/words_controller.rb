module Api::V1
  class WordsController < ApplicationController
    def index
      @words = Word.all.order(:word_name)
      render json: @words
      # functions, but still returns extra info
      # render json: { message: "Words successfully returned.", success: true, data: @words, each_serialize: WordSerializer }, status: 200

      # render json: { message: "Words successfully returned.", success: true, data: @words }, status: 200
      # render json: { message: "Words successfully returned.", success: true, data: @words, each_serializer: WordSerializer.new(@words) }, status: 200

      # render json: { message: "Words successfully returned.", success: true, data: WordSerializer.new(@words), each_serializer: WordSerializer }, status: 200
    end

    def show
      find_word
      render json: { message: "Word successfully returned.", success: true, data: WordSerializer.new(@word) }, status: 200
    end

    def new
    end

    def create
      if !find_word_by_name.nil?
        puts "=> Word #{params[:word][:word_name.downcase]} already exists."
        render json: { message: "Word already exists.", success: false, data: @word_by_name }, status: 200
        return
      end
      @word = Word.new(word_params)
      if @word.save
        puts "=> Word saved"
        render json: { message: "Word #{@word} successfully created.", success: true, data: @word }, status: 200
        Translation.find_info(@word.word_name.downcase)
      else
        puts "Word not saved"
        puts "Errors= #{@word.errors.full_messages.join(", ")}"
        render json: { message: "Word #{@word} NOT created because #{@word.errors.full_messages.join(", ")}", success: false, data: @word.errors.full_messages }, status: 406
      end
    end

    def edit
      find_word
    end

    def update
      find_word
      if @word.nil?
        puts "Word not found"
        render json: { message: "Word #{@word} not found", success: false }, status: 406
      end
      if @word.update(word_params)
        puts "Word updated"
        render json: { message: "Word #{@word} successfully updated.", success: true, data: @word }, status: 200
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
        render json: { message: "Word NOT successfully deleted.", success: false, data: @word.errors.full_messages.join(", ") }, status: 406
        puts "Error in delete: #{@word.errors.full_messages.join(", ")}"
      end
    end

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    def all_word_names
      @words = Word.all_word_names
      render json: { message: "All Word names successfully returned.", success: true, data: @words }, status: 200
    end

    def words_count
      @word_count = Word.words_count
      render json: { message: "Word count returned.", success: true, data: @word_count }, status: 200
    end

    def find_word_definition
      @word_definition = Word.find_word_definition(params[:word])
      render json: { message: "Word definition returned.", success: true, data: @word_definition }, status: 200
    end

    private

    def find_word
      @word = Word.find(params[:id])
    end

    def find_word_by_name
      @word_by_name = Word.find_by(word_name: params[:word][:word_name])
    end

    def find_existing_word_definition
      Word.find_by(word_name: params[:word])
    end

    def word_params
      params.require(:word).permit(:word_name, :definition)
    end
  end
end
