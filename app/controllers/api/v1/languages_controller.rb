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
      @macrofamilies = Language.select(:macrofamily).distinct.order(:macrofamily).pluck(:macrofamily)
      render json: { message: "Macrofamilies successfully returned.", success: true, data: @macrofamilies }, status: 200
    end

    def find_all_alphabets
      @alphabets = Language.select(:alphabet).order(:alphabet).distinct.pluck(:alphabet)
      render json: { message: "Alphabets successfully returned.", success: true, data: @alphabets }, status: 200
    end

    def find_all_languages_by_area
      @languages = Language.where("area1 = ?", params[:location]).or(Language.where("area2 = ?", params[:location])).or(Language.where("area3 = ?", params[:location]))
      render json: { message: "Languages successfully returned.", success: true, data: @languages }, status: 200
    end

    def find_all_areas
      # t1 = Time.now
      # @areas_ar = []
      # @areas_ar << Language.select(:area1).distinct.pluck(:area1)
      # @areas_ar << Language.select(:area2).distinct.pluck(:area2)
      # @areas_ar << Language.select(:area3).distinct.pluck(:area3)
      # puts @areas_ar

      # @areas = @areas_ar.flatten.compact.uniq.sort
      # puts "============="
      # puts @areas
      @areas = Language.select(:area1, :area2, :area3).distinct.pluck(:area1, :area2, :area3).flatten.uniq.reject{|x|x.empty?}.sort
      render json: { message: "All language areas successfully returned.", success: true, data: @areas }, status: 200
      # t2 = Time.now
      # time = t2 - t1
      # puts "+++++++++++++++++++++"
      # puts "find_all_areas: Done in #{time.round(4)} seconds"
    end

    def languages_count
      @languages = Language.count
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
