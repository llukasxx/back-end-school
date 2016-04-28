class Api::V1::SessionsController < Devise::SessionsController
 
  skip_before_filter :authenticate_user_from_token!
  respond_to :json
 
  def create
    user = User.find_for_database_authentication(email: params[:user][:email])
    if user && user.valid_password?(params[:user][:password])
      auth_token = jwt_token(user)
      respond_with do |format|
        format.json { render json: {auth_token: auth_token, user: user.name} }
      end
    else
      invalid_login_attempt
    end
  end
 
  private
  
    def invalid_login_attempt
      render json: {error: 'Invalid email or password.'}, status: :unauthorized
    end
 
end