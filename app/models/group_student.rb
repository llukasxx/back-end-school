class GroupStudent < ActiveRecord::Base
  validates :group_id, presence: true
  validates :student_id, presence: true
  
  belongs_to :student, class_name: 'User'
  belongs_to :group
end
