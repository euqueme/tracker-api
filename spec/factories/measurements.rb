FactoryBot.define do
  factory :measurement do
    description { Faker::Lorem.word }
    amount { Faker::Number.number(digits: 2) }
    user_id { nil }
    exercise_id { nil }
  end
end
