class ReceiptSerializer < ActiveModel::Serializer
  has_one :receiver, serializer: ReceiverSerializer
  attributes :mailbox_type, :id
end
