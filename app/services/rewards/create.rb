module Rewards
  class Create < ActiveInteraction::Base
    object :user

    def execute
      rewards = Rewards::Grant.run!(user: user)

      created_rewards = rewards.map do |reward|
        user.rewards.create!(
          reward_type: reward[:reward_type],
          reason: reward[:reason],
          awarded_at: Time.zone.now
        )
      end

      created_rewards
    end
  end
end
