class Lesson < ActiveRecord::Base
  # Validations
  validates :name, presence: true,
            length: {in: 3..40}
  # Associations
  has_many :group_lessons
  has_many :groups, through: :group_lessons
  has_many :teacher_lessons
  has_many :teachers, through: :teacher_lessons
  has_many :students, through: :groups
  has_many :lesson_dates
  #scopes
  scope :with_groups, -> { Lesson.all.includes(:groups) }
  #search
  include PgSearch
  pg_search_scope :search_by_name, 
                  against: :name,
                  using: { tsearch: { prefix: true } }
                  
  self.per_page = 10

end
