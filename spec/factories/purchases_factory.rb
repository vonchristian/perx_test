FactoryBot.define do
  factory :purchase do
    association :user
    amount_cents { 100 }
    currency { "USD" }
    country { "US" }
  end
end
