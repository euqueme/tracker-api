FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
