require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
  end

  describe '#foreign?' do
    let(:user) { FactoryBot.create(:user, country: 'US') }

    context 'when purchase country is the same as user country' do
      let(:purchase) { FactoryBot.build(:purchase, user: user, country: 'US') }

      it 'returns false' do
        expect(purchase.foreign?).to be false
      end
    end

    context 'when purchase country is different from user country' do
      let(:purchase) { FactoryBot.build(:purchase, user: user, country: 'FR') }

      it 'returns true' do
        expect(purchase.foreign?).to be true
      end
    end
  end
end
