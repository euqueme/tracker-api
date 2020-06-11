FactoryBot.define do
  factory :measurement do
    description { Faker::Lorem.words }
    amount { Faker::Number.number(digits: 10) }
    user_id { nil }
    exercise_id { nil }
  end
end
