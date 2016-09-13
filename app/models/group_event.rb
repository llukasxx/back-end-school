class GroupEvent < ActiveRecord::Base
  validates :group_id, presence: true
  validates :event_id, presence: true

  belongs_to :group
  belongs_to :event
end
