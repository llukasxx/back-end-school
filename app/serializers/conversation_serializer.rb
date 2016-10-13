class ConversationSerializer < ActiveModel::Serializer
  has_many :messages
  attributes :id, :subject

  def messages
    object.messages.includes(:sender, receipts: [:receiver])
  end
end
