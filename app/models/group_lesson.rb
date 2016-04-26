class GroupLesson < ActiveRecord::Base
  validates :group_id, presence: true
  validates :lesson_id, presence: true

  belongs_to :group
  belongs_to :lesson
end
