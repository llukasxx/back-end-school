class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :date
  has_one :creator, serializer: SimpleUserSerializer

  def date
    object.date.to_s(:db)
  end
end
