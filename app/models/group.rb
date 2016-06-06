class Group < ActiveRecord::Base
  # Validations
  validates :name, presence: true, 
                   uniqueness: true, 
                   length: {is: 5}

  ## Associations
  ## students associations
  has_many :group_students
  has_many :students, through: :group_students, class_name: 'User'
  ## lessons associations
  has_many :group_lessons
  has_many :lessons, through: :group_lessons
  ## teachers associations
  has_many :teachers, through: :lessons

  self.per_page = 10

end
