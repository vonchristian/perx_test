# spec/services/rewards/award_new_big_spenders_free_movie_ticket_spec.rb
require "rails_helper"

RSpec.describe Rewards::AwardNewBigSpendersFreeMovieTicket do
  let(:user) { FactoryBot.create(:user) }

  describe "#execute" do
    context "when user has not yet been awarded" do
      it "creates a free movie ticket reward" do
        reward = described_class.run!(user: user)

        expect(reward).to be_a(Reward)
        expect(reward.reward_type).to eq("free_movie_tickets")
        expect(reward.reason).to eq(Reward::REASON_NEW_USER_BIG_SPENDER)
        expect(reward.awarded_at).to be_within(1.second).of(Time.zone.now)
        expect(user.rewards).to include(reward)
      end
    end

    context "when user has already been awarded" do
      before do
        FactoryBot.create(:reward,
               reward_type: 'free_movie_tickets',
               user: user,
               reason: Reward::REASON_NEW_USER_BIG_SPENDER,
               awarded_at: Time.zone.now)
      end

      it "does not create a duplicate reward" do
        expect { described_class.run(user: user) }.not_to change(Reward, :count)
      end
    end
  end
end
