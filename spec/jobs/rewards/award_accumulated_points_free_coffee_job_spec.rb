require "rails_helper"

RSpec.describe Rewards::AwardAccumulatedPointsFreeCoffeeJob, type: :job do
  let!(:user) { FactoryBot.create(:user) }

  before do
    allow(Users::AccumulatedPointsQuery).to receive(:execute).and_return(User.where(id: user.id))
    allow(Rewards::AwardAccumulatedPointsFreeCoffee).to receive(:run)
  end

  it "calls the service with the correct params" do
    described_class.perform_now

    expect(Rewards::AwardAccumulatedPointsFreeCoffee)
      .to have_received(:run)
      .with(user: user)
  end
end
