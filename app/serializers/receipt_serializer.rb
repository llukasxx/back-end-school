class ReceiptSerializer < ActiveModel::Serializer
  has_one :receiver
  attributes :mailbox_type, :id
end
