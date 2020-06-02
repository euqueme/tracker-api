FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      email 'foo@bar.com'
      password_digest 'foobar'
      remember_digest 'foobar'
    end
  end