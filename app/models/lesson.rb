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
end
