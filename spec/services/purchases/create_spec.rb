# spec/services/purchases/create_service_spec.rb
require "rails_helper"

RSpec.describe Purchases::Create, type: :service do
  let(:user) { FactoryBot.create(:user) }
  let(:amount_cents) { 12_345 }
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

  context "with valid inputs" do
    it "creates a purchase record" do
      expect { service }.to change(Purchase, :count).by(1)
    end

    it "returns a valid purchase" do
      expect(service).to be_valid
      expect(service.user).to eq(user)
      expect(service.amount_cents).to eq(amount_cents)
      expect(service.country).to eq(country)
    end
  end

  context "with invalid inputs" do
    let(:amount_cents) { -100 }

    it "raises ActiveRecord::RecordInvalid" do
      expect { service }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
