FactoryBot.define do
    factory :exercise do
      name { Faker::Superhero.power }
      user_id nil
    end
  end