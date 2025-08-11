# spec/services/rewards/create_spec.rb
require "rails_helper"

RSpec.describe Rewards::Create, type: :model do
  let(:user) { FactoryBot.create(:user) }

  before do
    allow(Rewards::Grant).to receive(:run!).with(user: user).and_return(
      [
        { reward_type: :free_coffee, reason: "Monthly threshold" },
        { reward_type: :free_movie_tickets, reason: "New user big spender" }
      ]
    )
  end

  it "creates rewards for the user based on grant rules" do
    expect {
      described_class.run!(user: user)
    }.to change(user.rewards, :count).by(2)

    last_rewards = user.rewards.order(:created_at).last(2)
    expect(last_rewards.map(&:reward_type)).to contain_exactly("free_coffee", "free_movie_tickets")
    expect(last_rewards.map(&:reason)).to contain_exactly("Monthly threshold", "New user big spender")
  end
end
