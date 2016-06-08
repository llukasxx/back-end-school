class ReceiverGroupSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :lessons, serializer: SimpleLessonSerializer
  has_one :total_students

  def total_students
    object.students.count
  end
end
