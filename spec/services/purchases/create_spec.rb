require "rails_helper"

RSpec.describe Purchases::Create, type: :service do
  let(:user) { FactoryBot.create(:user) }
  let(:amount_cents) { 1_000_0 }
  let(:country) { "US" }
  let(:currency) { "USD" }

  subject(:service) do
    described_class.run(
      user: user,
      amount_cents: amount_cents,
      country: country,
      currency: currency
    )
  end

  it "creates a Purchase record" do
    expect { service }.to change(Purchase, :count).by(1)
  end

  it "creates a PointLedger record with correct points" do
    expect(PointsCalculator).to receive(:run!).and_return(10)

    expect { service }.to change(PointLedger, :count).by(1)

    point_ledger = PointLedger.last
    expect(point_ledger.user).to eq(user)
    expect(point_ledger.points).to eq(10)
  end

  context "when calculated points is zero or less" do
    it "does not create a PointLedger record" do
      allow(PointsCalculator).to receive(:run!).and_return(0)

      expect { service }.not_to change(PointLedger, :count)
    end
  end

  it "returns the created Purchase" do
    expect(service.result).to be_a(Purchase)
    expect(service.result.amount_cents).to eq(amount_cents)
    expect(service.result.currency).to eq(currency)
  end
end
