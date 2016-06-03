class MessageSerializer < ActiveModel::Serializer
  has_one :sender, class_name: "User"
  has_many :receipts
  attributes :body, :id, :conversation_id, :subject, :created_at

  def created_at
    object.created_at.to_s(:short)
  end
end
