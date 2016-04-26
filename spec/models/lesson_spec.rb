require 'rails_helper'

RSpec.describe Lesson, type: :model do
  # validations
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name) }
  # associations
  it { should have_many(:group_lessons) }
  it { should have_many(:groups) }
  it { should have_many(:teacher_lessons) }
  it { should have_many(:teachers) }
  it { should have_many(:students) }
  it { should have_many(:lesson_dates) }
end
