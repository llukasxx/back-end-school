class Api::V1::GradesController < ApplicationController
  before_action :authenticate_user_from_token!

  def show
    grade = Grade.find(params[:id])
    render json: grade    
  end

  def create
    if !params[:grade].empty?
      grade = @current_user.teacher_grades.new(grade_params)
      if grade.save!
        student = grade.student
        ## must be student bcz of front-end problems
        render json: student, root: "student", status: 201
      else
        render json: grade.errors, status: 400
      end
    elsif !params[:grades].empty?
      students_ids = []
      Grade.transaction do
        params[:grades].each do |g|
          new_grade = g.require(:grade).permit(:lesson_id, :student_id, :grade, :description)
          @current_user.teacher_grades.new(new_grade).save!
          students_ids.push(g[:grade][:student_id])
        end
      end
      students = User.where(id: students_ids)
      render json: students, root: "students", status: 201
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
