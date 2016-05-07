class GradeSerializer < ActiveModel::Serializer
  attributes :id, :grade, :lesson_id
end
