require 'rails_helper'

RSpec.describe Grade, type: :model do
  it { should belong_to(:student) }
  it { should belong_to(:teacher) }
  it { should belong_to(:lesson) }
  it { should validate_presence_of(:student_id) }
  it { should validate_presence_of(:teacher_id) }
  it { should validate_presence_of(:lesson_id) }
end
