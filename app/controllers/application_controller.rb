class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload) #{ user_id: 2 }
    JWT.encode(payload, "my_code") #issue a token, store payload in token
  end

  def auth_header
    request.headers["Authorization"] # Bearer <token>
  end

  def decoded_token
    if auth_header
      token = auth_header
    end
    begin
      JWT.decode(token, ENV["jwt_secret"], true, algorithm: "HS256")
      # JWT.decode => [{ "user_id"=>"2" }, { "alg"=>"HS256" }]
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      @user = User.find(user_id)
    else
      nil
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: {message: "Please log in", success: false} unless logged_in?
  end

end
