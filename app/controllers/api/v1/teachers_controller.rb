class Api::V1::TeachersController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
  end

  private

    def teacher_params
    end

end
