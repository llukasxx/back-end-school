class SimpleStudentLessonSerializer < ActiveModel::Serializer
  attributes :id, :name, :student_grades

  def student_grades
    # scope here is 'current_user'
    scope.student_grades.where(lesson_id: object.id)
  end
end
