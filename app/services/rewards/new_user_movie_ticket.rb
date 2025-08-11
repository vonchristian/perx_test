module Rewards
  class NewUserMovieTicket < ActiveInteraction::Base
    THRESHOLD = Money.new(100_000, "USD")
    DAYS = 60

    object :user

    def execute
      return false unless first_purchase_date

      within_days? && total_spent > THRESHOLD
    end

    def reward_type
      :free_movie_tickets
    end

    def reason
      "New user big spender"
    end

    private

    def first_purchase_date
      @first_purchase_date ||= user.first_purchase_at
    end

    def within_days?
      Time.current <= first_purchase_date + DAYS.days
    end

    def total_spent
      user.purchases
          .where(created_at: first_purchase_date..first_purchase_date + DAYS.days)
          .map(&:amount)
          .sum
    end
  end
end
