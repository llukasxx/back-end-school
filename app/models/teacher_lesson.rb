class TeacherLesson < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :teacher, class_name: 'User'
end
