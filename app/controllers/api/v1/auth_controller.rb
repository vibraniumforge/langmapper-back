module Api::V1
  class AuthController < ApplicationController
    skip_before_action :authorized, only: [:login], raise: false

    # def show
    #   @user = current_user
    #   if logged_in?
    #     render json: {message: "Logged in", success: true, data: @user}
    #   else
    #     render json: {message: "No user found", success: false }
    #   end
    # end

    def login
      puts "login fires"
      @user = User.find_by(name: params[:user][:name])
      if @user && @user.authenticate(params[:user][:password])
        message = "User Authenticated."
        puts "=> #{message}"
        token = encode_token({ user_id: @user.id })
        render json: { message: message, success: true, data: @user, jwt: token }
      else
        message = "Invalid username or password"
        puts "=> #{message}"
        render json: { message: message, success: false }
      end
    end

    private

    def user_login_params
      params.require(:auth).permit(:name, :password)
    end
  end
end
