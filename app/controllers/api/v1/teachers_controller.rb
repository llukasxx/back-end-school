class Api::V1::TeachersController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    teachers_count = User.teachers.count
    if teacher_params[:query] && !teacher_params[:query].empty?
      teachers = User.teachers_with_lessons.search_by_full_name(teacher_params[:query]).page(teacher_params[:page])
    else
      teachers = User.teachers_with_lessons.page(teacher_params[:page])
    end
    render json: teachers, each_serializer: TeacherSerializer, meta: { count: teachers_count }, status: :ok
  end

  private

    def teacher_params
      params.permit(:query, :page)
    end

end
