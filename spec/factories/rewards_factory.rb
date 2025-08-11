FactoryBot.define do
  factory :reward do
    association :user
    reward_type { "free_coffee" }
    reason { "big spender" }
    awarded_at { "2025-08-11 14:06:20" }
  end
end
