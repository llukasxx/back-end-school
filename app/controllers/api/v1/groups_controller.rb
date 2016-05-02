class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user_from_token!

  def teacher_groups
    render json: @current_user.groups_teacher
  end

  def teacher_group
    group = Group.find(params[:id])
    render json: group
  end

end
