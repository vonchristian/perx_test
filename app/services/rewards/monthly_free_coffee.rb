module Rewards
  class MonthlyFreeCoffee < ActiveInteraction::Base
    THRESHOLD = 100

    object :user
    date :date, default: Date.current

    def execute
      user.point_ledgers.total_points_for_month(date) >= THRESHOLD
    end

    def reward_type
      :free_coffee
    end

    def reason
      "Monthly threshold"
    end
  end
end
