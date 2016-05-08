class Api::V1::GradesController < ApplicationController
  before_action :authenticate_user_from_token!

  def show
    grade = Grade.find(params[:id])
    render json: grade    
  end

  def create
    grade = Grade.new(grade_params)
    if grade.save!
      render json: grade, status: 201
    else
      render json: grade.errors, status: 400
    end
  end

  def update
    grade = Grade.find(params[:id])
    if grade.update_attributes(grade_params)
      render json: grade, status: 201
    else
      render json: grade.errors, status: 400
    end
  end

  private

    def grade_params
      params.require(:grade).permit(:lesson_id, :teacher_id, :student_id, :grade, :description)
    end

end
