module Rewards
  class AwardAccumulatedPointsFreeCoffeeJob < ApplicationJob
    queue_as :default

    def perform
      Users::AccumulatedPointsQuery.execute.find_each do |user|
        Rewards::AwardAccumulatedPointsFreeCoffee.run(user: user)
      end
    end
  end
end
