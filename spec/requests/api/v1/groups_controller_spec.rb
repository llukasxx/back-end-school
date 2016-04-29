require 'rails_helper'

describe "Groups API" do

  before(:each) do
    @user = create(:user, account_type: 'teacher')
    @token = get_token_for_user(@user)
  end

  it 'wont send groups to unauth user' do
    get "/api/v1/groups/user_groups"
    expect(response.status).to eq 401
  end

  it "returns 200 for proper request" do
    get "/api/v1/groups/user_groups", nil, {"Authorization": @token}
    expect(response.status).to eq 200
  end
end