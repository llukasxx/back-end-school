class Api::V1::TeachersController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    if teacher_params[:query] && !teacher_params[:query].empty?
      teachers = User.teachers_with_lessons.search_by_full_name(teacher_params[:query]).page(teacher_params[:page])
      teachers_count = teachers.count
      render json: teachers, each_serializer: TeacherSerializer, meta: { count: teachers_count }
    else
      teachers = User.teachers_with_lessons.page(teacher_params[:page])
      teachers_count = User.teachers.count
      render json: teachers, each_serializer: TeacherSerializer, meta: { count: teachers_count }
    end
  end

  private

    def teacher_params
      params.permit(:query, :page)
    end

end
