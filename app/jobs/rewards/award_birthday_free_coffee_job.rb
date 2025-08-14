module Rewards
  class AwardBirthdayFreeCoffeeJob < ApplicationJob
    queue_as :default

    def perform
      Users::BirthdayQuery.execute.find_each do |user|
        Rewards::AwardBirthdayFreeCoffee.run(user: user)
      end
    end
  end
end
