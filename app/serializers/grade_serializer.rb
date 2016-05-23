class GradeSerializer < ActiveModel::Serializer
  attributes :id, :grade, :description, :lesson_id, :student_id
end
