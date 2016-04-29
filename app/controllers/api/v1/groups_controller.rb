class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user_from_token!

  def user_groups
    render json: {hey: "ho"}
  end

end
