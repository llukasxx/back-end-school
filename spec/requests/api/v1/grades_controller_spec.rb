require 'rails_helper'

describe "Grades API" do

  describe "#show" do
    before(:each) do
      @user = create(:user, account_type: 'student')
      @token = get_token_for_user(@user)
      @grade = create(:grade, student_id: @user.id)
      @url = "/api/v1/students/grades/#{@grade.id}"
    end

    it 'won\'t send grade to unauth user' do
      get @url, nil, {"Authorization": "some fake token"}
      expect(response.status).to eq 401
    end

    it "returns 200 for proper request" do
      get @url, nil, {"Authorization": @token}
      expect(response.status).to eq 200
    end
  end

  describe "#create" do
    before(:each) do
      @user = create(:user, account_type: 'teacher')
      @token = get_token_for_user(@user)
      @grade = {grade: {student_id: 1, lesson_id: 1, teacher_id: @user.id, grade: 5}}
      @url = "/api/v1/students/grades"
    end

    it 'won\'t allow unauth user to create grade' do
      post @url, @grade, {"Authorization": "some fake token"}
      expect(response.status).to eq 401
    end

    it "creates grade with proper request" do
      post @url, @grade, {"Authorization": @token}
      expect(response.status).to eq 201
    end

  end

  describe "#update" do
    before(:each) do
      @user = create(:user, account_type: 'teacher')
      @token = get_token_for_user(@user)
      @grade = create(:grade, grade: 5)
      @new_grade = {grade: {grade: "4"}}
      @url = "/api/v1/students/grades/#{@grade.id}"
    end

    it 'updates grade' do
      patch @url, @new_grade, {"Authorization": @token}
      expect(Grade.find(@grade.id).grade).to eq @new_grade[:grade][:grade]
    end
  
  end


end