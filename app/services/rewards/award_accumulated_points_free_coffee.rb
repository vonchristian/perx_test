module Rewards
  class AwardAccumulatedPointsFreeCoffee < ActiveInteraction::Base
    object :user

    def execute
      return if already_awarded_this_month?

      reward = create_reward
      # notify_user
      reward
    end

    private

    def already_awarded_this_month?
      user.rewards.free_coffee.exists?(
        awarded_at: Time.zone.now.all_month,
        reason: Reward::REASON_MONTHLY_ACCUMULATED_POINTS
      )
    end

    def create_reward
      user.rewards.create!(
        reward_type: "free_coffee",
        reason: Reward::REASON_MONTHLY_ACCUMULATED_POINTS,
        awarded_at: Time.zone.now
      )
    end
  end
end
