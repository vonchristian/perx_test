FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email  }
    birth_date { Date.current - 20.years }
    country { "US" }
    first_purchase_at { Time.current.last_month }
  end
end
