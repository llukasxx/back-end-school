class Event < ActiveRecord::Base
  scope :upcoming, -> { where('date >= ?', Time.now).reorder(date: :asc) }
  scope :past, -> { where('date < ?', Time.now) }
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :groups, through: :group_events
  has_many :group_events
  accepts_nested_attributes_for :groups
  self.per_page = 5
end
