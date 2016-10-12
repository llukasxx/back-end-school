class Api::V1::StudentsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    if student_params[:query] && !student_params[:query].empty?
      students = User.students_with_groups.search_by_full_name(student_params[:query]).page(student_params[:page])
      student_count = students.count
    else
      students = User.students_with_groups.page(student_params[:page])
      student_count = User.students.count
    end
    render json: students, each_serializer: StudentSerializer, meta: { count: student_count }, status: :ok
  end

  private

    def student_params
      params.permit(:query, :page)
    end
   
end
