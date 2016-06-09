class Api::V1::TeachersController < ApplicationController
  before_action :authenticate_user_from_token!
  
  def get_teachers
    if params[:query] && !params[:query].empty?
      teachers = User.where(account_type: 'teacher').search_by_full_name(params[:query]).includes(:lessons).paginate(page: params[:page])
      count = teachers.count
      teachers = teachers.map {|s| TeacherSerializer.new(s).as_json(root: false) }
      render json: { teachers: teachers, count: count }
    else
      teachers = User.where(account_type: 'teacher').includes(:lessons).paginate(page: params[:page])
      count = User.where(account_type: 'teacher').count
      teachers = teachers.map {|s| TeacherSerializer.new(s).as_json(root: false) }
      render json: { teachers: teachers, count: count }
    end
  end
end
