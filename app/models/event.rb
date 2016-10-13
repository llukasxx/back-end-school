class Event < ActiveRecord::Base
  scope :upcoming, -> { where('date >= ?', Time.now).includes(:groups, :creator).reorder(date: :asc) }
  scope :past, -> { where('date < ?', Time.now).includes(:groups, :creator) }

  scope :upcoming_connected, lambda { |user| 
    user_groups_ids = user.groups_teacher.pluck(:id).uniq
    upcoming.joins(:groups).where('groups.id': user_groups_ids).uniq
  }
  scope :upcoming_created, lambda { |user|
    upcoming.where(user_id: user.id)
  }

  scope :past_connected, lambda { |user|
    user_groups_ids = user.groups_teacher.pluck(:id).uniq
    past.joins(:groups).where('groups.id': user_groups_ids).uniq
  }
  scope :past_created, lambda { |user|
    past.where(user_id: user.id)
  }

  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :groups, through: :group_events
  has_many :group_events
  accepts_nested_attributes_for :groups
  self.per_page = 5
end
