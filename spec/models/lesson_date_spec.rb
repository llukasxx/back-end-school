require 'rails_helper'

RSpec.describe LessonDate, type: :model do
  it { should validate_presence_of(:date) }

  it { should belong_to(:lesson)}
end
