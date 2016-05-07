class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name
  has_many :student_grades
  has_many :teacher_grades
end
