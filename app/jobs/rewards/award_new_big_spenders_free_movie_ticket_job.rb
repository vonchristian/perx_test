module Rewards
  class AwardNewBigSpendersFreeMovieTicketJob < ApplicationJob
    queue_as :default

    def perform
      Users::NewBigSpendersQuery.execute.find_each do |user|
        Rewards::AwardNewBigSpendersFreeMovieTicket.run(user: user)
      end
    end
  end
end
