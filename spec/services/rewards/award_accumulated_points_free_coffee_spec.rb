require "rails_helper"

RSpec.describe Rewards::AwardAccumulatedPointsFreeCoffee do
  let(:user) { FactoryBot.create(:user) }

  describe "#execute" do
    context "when user has not yet been awarded this month" do
      it "creates a free coffee reward" do
        result = described_class.run!(user: user)

        expect(result).to be_a(Reward)
        expect(result.reward_type).to eq("free_coffee")
        expect(result.reason).to eq(Reward::REASON_MONTHLY_ACCUMULATED_POINTS)
        expect(result.awarded_at).to be_within(1.second).of(Time.zone.now)
        expect(user.rewards).to include(result)
      end
    end

    context "when user has already been awarded this month" do
      before do
        FactoryBot.create(:reward, :free_coffee,
               user: user,
               reason: Reward::REASON_MONTHLY_ACCUMULATED_POINTS,
               awarded_at: Time.zone.now)
      end

      it "returns nil and does not create another reward" do
        expect { described_class.run(user: user) }.not_to change(Reward, :count)
      end
    end
  end
end
