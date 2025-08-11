module Rewards
  class Grant < ActiveInteraction::Base
    RULES = [
      Rewards::MonthlyFreeCoffee,
      Rewards::BirthdayFreeCoffee,
      Rewards::NewUserMovieTicket
    ].freeze

    object :user

    def execute
      RULES.each_with_object([]) do |rule_class, rewards|
        rule = rule_class.run(user: user)
        if rule.result
          rewards << {
            reward_type: rule.reward_type,
            reason: rule.reason
          }
        end
      end
    end
  end
end
