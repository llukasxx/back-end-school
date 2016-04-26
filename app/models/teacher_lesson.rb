class TeacherLesson < ActiveRecord::Base
  validates :lesson_id, presence: true
  validates :teacher_id, presence: true
  belongs_to :lesson
  belongs_to :teacher, class_name: 'User'
end
