module Api::V1
  class UsersController < ApplicationController
    # skip_before_action :authorized, only: [:create]

    def index
      @users = User.all
      render json: @users
    end

    def show
      @users = User.find(params[:id])
      render json: @users
    end

    def new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        puts "=> User saved"
        render json: { message: "User #{@user} successfully created.", success: true, data: @user }, status: 200
      else
        puts "User not saved"
        puts "Errors= #{@user.errors.full_messages.join(", ")}"
        render json: { message: "User #{@user} NOT created because #{@user.errors.full_messages.join(", ")}", success: false, data: @word.errors.full_messages }, status: 406
      end
    end

    private
    def word_params
      params.require(:word).permit(:name, :password)
    end
  end
end