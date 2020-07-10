module Api::V1
  class AuthController < ApplicationController
    # skip_before_action :authorized, only: [:login]

    def show
      @user = current_user
      if logged_in?
        render json: {message: "Logged in", success: true, data: @user}
      else
        render json: {message: "No user found", success: false }
      end
    end

    def login
      puts "in login"
      @user = User.find_by(name: params[:user][:name])
      if @user && @user.authenticate(params[:user][:password])
        token = encode_token({ user_id: @user.id})
        render json: {message: "Success", success: true, data: @user, jwt: token }
      else
        puts "Invalid username or password"
        render json: {message: "Invalid username or password", success: false }
      end
    end

    private

    def user_login_params
      params.require(:auth).permit(:username, :password)
    end

  end
end