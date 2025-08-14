module Rewards
  class Award < ActiveInteraction::Base
    AWARDS = [
      Rewards::AwardBirthdayFreeCoffee,
      Rewards::AwardAccumulatedPointsFreeCoffee
    ].freeze

    object :user

    def execute
      AWARDS.map do |award_klass|
        award_klass.run(user: user)
      end

      user
    end
  end
end
