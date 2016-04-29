FactoryGirl.define do
  factory :user do
    first_name "Jan"
    last_name "Kowalski"
    email "teacher@example.com"
    password "password"
    account_type "teacher"
  end
end