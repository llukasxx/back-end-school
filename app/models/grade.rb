class Grade < ActiveRecord::Base
  belongs_to :student, class_name: 'User'
  belongs_to :teacher, class_name: 'User'
  belongs_to :lesson

  validates :student_id, presence: true
  validates :teacher_id, presence: true
  validates :lesson_id, presence: true
  validates :grade, presence: true
end
