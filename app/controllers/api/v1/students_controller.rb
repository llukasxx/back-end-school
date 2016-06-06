class Api::V1::StudentsController < ApplicationController
  before_action :authenticate_user_from_token!

  def get_students
    students = User.where(account_type: 'student').includes(:student_groups)
    count = students.count
    students = students.map {|s| StudentSerializer.new(s).as_json(root: false) }
    render json: { students: students, count: count }
  end
   
end
