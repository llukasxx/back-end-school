class Api::V1::StudentsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index

  end

  private

    def query_params
      
    end
   
end