require "rails_helper"

RSpec.describe Rewards::AwardNewBigSpendersFreeMovieTicketJob, type: :job do
  let!(:user) { FactoryBot.create(:user) }

  before do
    allow(Users::NewBigSpendersQuery).to receive(:execute).and_return(User.where(id: user.id))
    allow(Rewards::AwardNewBigSpendersFreeMovieTicket).to receive(:run)
  end

  it "calls the service with the correct params" do
    described_class.perform_now

    expect(Rewards::AwardNewBigSpendersFreeMovieTicket)
      .to have_received(:run)
      .with(user: user)
  end
end
