class LessonDate < ActiveRecord::Base
  # Validations
  validates :date, presence: true
  # Associations
  belongs_to :lesson
end
