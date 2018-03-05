# spec/factories/user.rb
FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password { 'abc123' }
    password_confirmation { 'abc123' }
  end
end
