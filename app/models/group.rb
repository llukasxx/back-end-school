class Group < ActiveRecord::Base
  # Validations
  validates :name, presence: true, 
                   uniqueness: true, 
                   length: {is: 5}
  scope :with_lessons, -> { Group.all.includes(:lessons) }
  ## Associations
  ## students associations
  has_many :group_students
  has_many :students, through: :group_students, class_name: 'User'
  ## lessons associations
  has_many :group_lessons
  has_many :lessons, through: :group_lessons
  ## teachers associations
  has_many :teachers, through: :lessons
  # events association
  has_many :events, through: :group_events
  has_many :group_events
  self.per_page = 10
  #search
  include PgSearch
  pg_search_scope :search_by_name, 
                  against: [:name],
                  using: { tsearch: { prefix: true } }

end
