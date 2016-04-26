require 'rails_helper'

RSpec.describe GroupStudent, type: :model do
  it { should belong_to(:group) }
  it { should belong_to(:student) }
  it { should validate_presence_of(:group_id) }
  it { should validate_presence_of(:student_id) }
end
