class Event < ActiveRecord::Base
  scope :upcoming, -> { where('date >= ?', Time.now) }
  scope :past, -> { where('date < ?', Time.now) }
  belongs_to :creator, class_name: "User", foreign_key: "user_id"


  self.per_page = 5
end
