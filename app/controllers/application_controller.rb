class ApplicationController < ActionController::Base 
  require 'json_web_token' 

  protect_from_forgery with: :null_session

  protected 

    def authenticate_user_from_token! 
      if claims and user = User.find_by(email: claims[0]['user']) 
        @current_user = user 
      else 
        invalid_authentication 
      end 
    end 

    def jwt_token(user) 
      JsonWebToken.encode('user' => user.email)
    end

    def claims
      auth_header = request.headers['Authorization'] and
      token = auth_header.split(' ').last and
      JsonWebToken.decode(token)
    rescue
      nil
    end
   
    def invalid_authentication
      render json: {error: t('devise.failure.unauthenticated')}, status: :unauthorized
    end
 
end