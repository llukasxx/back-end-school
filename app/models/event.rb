class Event < ActiveRecord::Base
  # Scopes
  scope :upcoming, -> { where('date >= ?', Time.now)
                        .includes(:groups, :creator)
                        .reorder(date: :asc) }
  scope :past, -> { where('date < ?', Time.now)
                    .includes(:groups, :creator) }

  scope :connected, -> (user) {  
    user_groups_ids = user.groups_teacher.pluck(:id).uniq
    joins(:groups).where('groups.id': user_groups_ids).uniq
  }
  scope :created, -> (user) {
    where(user_id: user.id)
  }
  
  # Associations
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :groups, through: :group_events
  has_many :group_events
  accepts_nested_attributes_for :groups

  # Pagination
  self.per_page = 5
end
