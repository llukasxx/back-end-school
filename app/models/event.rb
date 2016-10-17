class Event < ActiveRecord::Base
  scope :upcoming, -> { where('date >= ?', Time.now).includes(:groups, :creator).reorder(date: :asc) }
  scope :past, -> { where('date < ?', Time.now).includes(:groups, :creator) }

  scope :connected, -> (user) {  
    user_groups_ids = user.groups_teacher.pluck(:id).uniq
    joins(:groups).where('groups.id': user_groups_ids).uniq
  }
  scope :created, -> (user) {
    where(user_id: user.id)
  }

  scope :filtered, -> (args) {
    if(args[:filter] == 'upcoming' && args[:kind] == 'connected')
      upcoming.connected(args[:user])
    elsif(args[:filter] == 'upcoming' && args[:kind] == 'created')
      upcoming.created(args[:user])
    elsif(args[:filter] == 'past' && args[:kind] == 'connected')
      past.connected(args[:user])
    elsif(args[:filter] == 'past' && args[:kind] == 'created')
      past.created(args[:user])
    elsif(args[:filter] == 'upcoming')
      upcoming
    elsif(args[:filter] == 'past')
      past
    else
      all      
    end
  }

  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :groups, through: :group_events
  has_many :group_events
  accepts_nested_attributes_for :groups
  self.per_page = 5


end
