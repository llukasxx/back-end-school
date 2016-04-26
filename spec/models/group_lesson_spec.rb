require 'rails_helper'

RSpec.describe GroupLesson, type: :model do
  it { should belong_to(:group) }
  it { should belong_to(:lesson) }
  it { should validate_presence_of(:group_id) }
  it { should validate_presence_of(:lesson_id) }
end
