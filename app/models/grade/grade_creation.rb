class Grade
  class GradeCreation
    attr_reader :user, :grade_params
    attr_accessor :students, :grades
    def initialize(user, grade_params)
      @user = user
      @grade_params = grade_params
      @students = []
      @grades = []
    end

    def save!
      if grade_params[:grades].present?
        Grade.transaction do
          grade_params[:grades].each do |g|
            save_grade(g)
          end
        end
      elsif grade_params[:grade].present?
        save_grade(grade_params)
      else
        raise ArgumentError, 'Wrong params provided'
      end
    end

    def errors
      grades.errors
    end

    private
      def save_grade(grade)
        new_grade = grade.require(:grade).permit(:lesson_id, :student_id, :grade, :description)
        grade = user.teacher_grades.create(new_grade)
        students.push(grade.student)
        grades.push(grade)
      end
  end
end