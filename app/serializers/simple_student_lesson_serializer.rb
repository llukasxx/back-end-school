class SimpleStudentLessonSerializer < ActiveModel::Serializer
  attributes :id, :name 
  has_many :lesson_dates, serializer: LessonDatesSerializer
  has_many :student_grades, serializer: GradeSerializer

  def student_grades
    # scope here is 'current_user'
    scope.student_grades.where(lesson_id: object.id)
  end
end
