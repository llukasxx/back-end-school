class Api::V1::StudentsController < ApplicationController
  before_action :authenticate_user_from_token!

  def get_students
    if student_params[:query] && !student_params[:query].empty?
      students = User.where(account_type: 'student').search_by_full_name(params[:query]).includes(:student_groups)
      count = students.count
      students = students.map {|s| StudentSerializer.new(s).as_json(root: false) }
      render json: { students: students, count: count }
    else
      students = User.where(account_type: 'student').includes(:student_groups).paginate(page: params[:page])
      count = User.where(account_type: 'student').count
      students = students.map {|s| StudentSerializer.new(s).as_json(root: false) }
      render json: { students: students, count: count }
    end
  end

  private

    def student_params
      params.permit(:query, :page)
    end
   
end
