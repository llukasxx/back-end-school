class User < ActiveRecord::Base
  # Devise
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable
  # Validations
  validates :first_name, presence: true,
            length: {in: 2..20}
  validates :last_name, presence: true,
            length: {in: 2..30}
  validates :account_type, presence: true, 
            format: {with: /admin|teacher|student/}
  # Associations

  ## Teachers to group association
  has_many :teacher_groups, through: :teacher_lessons, source: :lesson
  has_many :groups_teacher, through: :teacher_groups, source: :groups
  ## Teachers to lesson association
  has_many :teacher_lessons, foreign_key: :teacher_id
  has_many :lessons, through: :teacher_lessons
  ## Students to group/teacher/lesson association
  has_many :group_students, foreign_key: :student_id
  has_many :student_groups, through: :group_students, source: :group
  has_many :student_lessons, through: :student_groups, source: :lessons
  #Student/Teacher-grades
  has_many :student_grades, class_name: 'Grade', foreign_key: 'student_id'
  has_many :teacher_grades, class_name: 'Grade', foreign_key: 'teacher_id'
  acts_as_messageable

  def name
    "#{first_name} #{last_name}"
  end

  def admin?
    account_type == 'admin'
  end
end
