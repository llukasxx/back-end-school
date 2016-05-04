class LessonDate < ActiveRecord::Base

  default_scope { order(date: 'ASC') }
  # Validations
  validates :date, presence: true
  # Associations
  belongs_to :lesson

end
