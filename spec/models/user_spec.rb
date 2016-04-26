require 'rails_helper'

RSpec.describe User, type: :model do
  # validations
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:account_type) }

  it { should validate_length_of(:first_name) }
  it { should validate_length_of(:last_name) }

  # associations
  # as teacher
  it { should have_many(:teacher_groups) }
  it { should have_many(:groups_teacher) }
  it { should have_many(:teacher_lessons) }
  it { should have_many(:lessons) }

  # as student
  it { should have_many(:student_groups) }
  it { should have_many(:group_students) }
  it { should have_many(:student_lessons) }
  
  
end
