class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user_from_token!
  
  def index
    render json: {its: "done"}
  end
end
