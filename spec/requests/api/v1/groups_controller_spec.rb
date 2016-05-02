require 'rails_helper'

describe "Groups API" do

  describe "#teacher_groups" do
    before(:each) do
      @user = create(:user, account_type: 'teacher')
      @token = get_token_for_user(@user)
      @url = "/api/v1/groups/teacher_groups"
    end

    it 'wont send groups to unauth user' do
      get @url, nil, {"Authorization": "some fake token"}
      expect(response.status).to eq 401
    end

    it "returns 200 for proper request" do
      get @url, nil, {"Authorization": @token}
      expect(response.status).to eq 200
    end
  end

  describe "#teacher_group" do
    before(:each) do
      @user = create(:user, account_type: 'teacher')
      @group = create(:group)
      @token = get_token_for_user(@user)
      @url = "/api/v1/groups/teacher_group"
    end

    it 'wont send group to unauth user' do
      get @url, nil, {"Authorization": "some fake token"}
      expect(response.status).to eq 401
    end

    it "returns 200 for proper request" do
      get @url, {id: @group.id}, {"Authorization": @token}
      expect(response.status).to eq 200
    end

    it "returns proper group" do
      get @url, {id: @group.id}, {"Authorization": @token}
      json = JSON.parse(response.body)
      puts json
      expect(json["group"]["name"]).to eq @group.name
    end
  end

end