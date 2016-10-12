class ReceiverLessonSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :groups, serializer: SimpleGroupSerializer
  has_one :total_students
  def total_students
    object.students.count
  end

end
