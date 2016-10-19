class Api::V1::GradesController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    
  end

  def show
    grade = Grade.find(params[:id])
    render json: grade    
  end

  def create
    grade = Grade::GradeCreation.new(@current_user, params)
    if grade.save!
      render json: grade.students, root: 'students', status: :created
    else
      render json: grade.errors
    end
  end

  def update
    grade = Grade.find(params[:id])
    if grade.update_attributes(grade_params)
      student = grade.student
      render json: student, root: "student", status: 201
    else
      render json: grade.errors, status: 400
    end
  end

  private

    def grade_params
      params.require(:grade).permit(:lesson_id, :student_id, :grade, :description)
    end

end
