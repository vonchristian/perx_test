module Rewards
  class AwardNewBigSpendersFreeMovieTicket < ActiveInteraction::Base
    object :user

    def execute
      return unless eligible_for_reward?

      user.rewards.create!(
        reward_type: "free_movie_tickets",
        reason: Reward::REASON_NEW_USER_BIG_SPENDER,
        awarded_at: Time.zone.now
      )
    end

    private

    def eligible_for_reward?
      !user.rewards.free_movie_tickets.exists?(
        reason: Reward::REASON_NEW_USER_BIG_SPENDER
      )
    end
  end
end
