require 'rails_helper'

RSpec.describe TeacherLesson, type: :model do
  it { should belong_to(:lesson) }
  it { should belong_to(:teacher) }
  it { should validate_presence_of(:lesson_id) }
  it { should validate_presence_of(:teacher_id) }
end
