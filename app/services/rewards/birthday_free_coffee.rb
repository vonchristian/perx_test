module Rewards
  class BirthdayFreeCoffee < ActiveInteraction::Base
    object :user

    def execute
      user.birth_date&.month == Time.zone.now.month
    end

    def reward_type
      :free_coffee
    end

    def reason
      "Birthday month"
    end
  end
end
