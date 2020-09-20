module Api::V1
  class WordsController < ApplicationController
    before_action :authorized, only: [:show, :new, :create, :edit, :update, :destroy]
    # skip_before_action :authorized, only: [:index, :all_word_names, :words_count, :find_word_definition, :find_word, :find_word_by_name]

    def index
      @words = Word.all.order(id: :desc)
      render json: @words
      # functions, but still returns extra info
      # render json: { message: "Words successfully returned.", success: true, data: @words, each_serializer: WordSerializer }, status: 200

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
        message = "Word #{params[:word][:word_name.downcase]} already exists."
        puts "\n"
        puts "=> #{message}"
        render json: { message: message, success: false, data: @word_by_name.errors.full_messages }, status: 200
        return
      end
      @word = Word.new(word_params)
      if @word.save
        message = "Word #{@word.word_name} successfully created."
        puts "=> #{message}"
        puts "\n"
        render json: { message: message, success: true, data: @word }, status: 200
        # Translation.find_info(@word.word_name.downcase)
        FindInfoService.find_info(@word.word_name.downcase)
      else
        message = "Word #{@word} NOT created"
        puts "=> #{message}"
        puts "Errors= #{@word.errors.full_messages.join(", ")}"
        render json: { message: "#{message} because #{@word.errors.full_messages.join(", ")}", success: false, data: @word.errors.full_messages }, status: 406
      end
    end

    def edit
      find_word
    end

    def update
      find_word
      if @word.nil?
        message = "Word #{@word} not found"
        puts "=> #{message}"
        render json: { message: message, success: false }, status: 406
      end
      if @word.update(word_params)
        message = "Word #{@word.word_name} successfully updated."
        puts "=> #{message}"
        render json: { message: message, success: true, data: @word }, status: 200
      else
        message = "Word #{@word} NOT updated"
        puts "=> #{message}"
        puts "Errors= #{@word.errors.full_messages.join(", ")}"
        render json: { message: "#{message} because #{@word.errors.full_messages.join(", ")}", success: false, data: @word.errors.full_messages }, status: 406
      end
    end

    def destroy
      find_word
      if @word.destroy
        message = "Word << #{@word.word_name} >> successfully deleted."
        puts "=> #{message}"
        render json: { message: message, success: true, data: @word }, status: 200
      else
        message = "Word << #{@word} >> NOT successfully deleted."
        puts "=> #{message}"
        puts "Error in delete: #{@word.errors.full_messages.join(", ")}"
        render json: { message: "#{message} because #{@word.errors.full_messages.join(", ")}", success: false, data: @word.errors.full_messages.join(", ") }, status: 406
      end
    end

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

    def all_word_names
      @word_names = Word.all_word_names
      render json: { message: "All Word names successfully returned.", success: true, data: @word_names }, status: 200
    end

    def words_count
      @word_count = Word.words_count
      render json: { message: "Words count successfully returned.", success: true, data: @word_count }, status: 200
    end

    def find_word_definition
      @word_definition = Word.find_word_definition(params[:word])
      render json: { message: "Word #{params[:word]} definition successfully returned.", success: true, data: @word_definition }, status: 200
    end

    private

    def find_word
      @word = Word.find(params[:id])
    end

    def find_word_by_name
      @word_by_name = Word.find_by(word_name: params[:word][:word_name].downcase)
    end

    def word_params
      params.require(:word).permit(:word_name, :definition)
    end
  end
end
