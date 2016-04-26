require 'rails_helper'

RSpec.describe Group, type: :model do
  # validations
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_length_of(:name) }
  # associations
  it { should have_many(:group_students) }
  it { should have_many(:students) }
  it { should have_many(:group_lessons) }
  it { should have_many(:lessons) }
  it { should have_many(:events) }
  it { should have_many(:group_events) }
  it { should have_many(:teachers) }
end
