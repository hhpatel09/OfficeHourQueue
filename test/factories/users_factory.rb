FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    role_id { 1 }
    uid { 1 }
    session_token { 5 }
    email { 'hi@email.com'}
    end
  end
