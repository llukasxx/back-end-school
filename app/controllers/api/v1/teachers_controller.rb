class Api::V1::TeachersController < ApplicationController
  def get_teachers
    teachers = User.where(account_type: 'teacher').includes(:teacher_lessons).paginate(page: params[:page])
    count = User.where(account_type: 'teacher').count
    teachers = teachers.map {|s| TeacherSerializer.new(s).as_json(root: false) }
    render json: { teachers: teachers, count: count }
  end
end
