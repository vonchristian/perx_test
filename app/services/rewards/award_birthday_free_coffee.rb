module Rewards
  class AwardBirthdayFreeCoffee < ActiveInteraction::Base
    object :user

    def execute
      return unless eligible_for_birthday_reward?

      reward = create_reward
      # notify_user
      reward
    end

    private

    def eligible_for_birthday_reward?
      birthday_today? && !already_awarded_this_month?
    end

    def birthday_today?
      return false unless user.birth_date

      today = Time.zone.now
      user.birth_date.month == today.month && user.birth_date.day == today.day
    end

    def already_awarded_this_month?
      user.rewards.free_coffee.exists?(
        awarded_at: Time.zone.now.all_month,
        reason: Reward::REASON_BIRTHDAY_MONTH
      )
    end

    def create_reward
      user.rewards.create!(
        reward_type: "free_coffee",
        reason: Reward::REASON_BIRTHDAY_MONTH,
        awarded_at: Time.zone.now
      )
    end
  end
end
