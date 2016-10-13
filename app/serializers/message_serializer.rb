class MessageSerializer < ActiveModel::Serializer
  has_one :sender, serializer: SimpleUserSerializer
  has_many :receipts, serializer: ReceiptSerializer
  attributes :body, :id, :conversation_id, :subject, :created_at

  def created_at
    object.created_at.to_s(:short)
  end

  def receipts
    object.receipts.includes(:receiver)
  end
end
