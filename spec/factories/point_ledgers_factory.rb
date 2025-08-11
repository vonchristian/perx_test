FactoryBot.define do
  factory :point_ledger do
    association :user
    association :purchase
    points { 1 }
    reason { "free_coffee" }
  end
end
