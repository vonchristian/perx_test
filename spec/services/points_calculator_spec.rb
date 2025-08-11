require 'rails_helper'

RSpec.describe PointsCalculator, type: :model do
  let(:user) { FactoryBot.create(:user, country: 'US') }

  context 'when purchase is domestic' do
    let(:purchase) { FactoryBot.build(:purchase, user: user, amount_cents: 150_00, currency: 'USD', country: 'US') }

    it 'calculates points normally' do
      result = described_class.run!(purchase: purchase)
      expect(result).to eq(10) # floor(150/100)=1 * 10 points
    end
  end

  context 'when purchase is foreign' do
    let(:purchase) { FactoryBot.build(:purchase, user: user, amount_cents: 150_00, currency: 'USD', country: 'FR') }

    it 'doubles the points' do
      result = described_class.run!(purchase: purchase)
      expect(result).to eq(20) # doubled points
    end
  end
end
