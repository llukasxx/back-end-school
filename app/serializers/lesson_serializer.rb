class LessonSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :students
  has_many :lesson_dates, serializer: LessonDatesSerializer
end
