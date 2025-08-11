# spec/services/rewards/monthly_free_coffee_spec.rb
require 'rails_helper'

RSpec.describe Rewards::MonthlyFreeCoffee, type: :model do
  let(:date) { Date.current }
  let(:user) {  FactoryBot.create(:user) }

  subject(:service) { described_class.run(user: user, date: date) }

  describe '#execute' do
    context 'when user has fewer points than threshold' do
      before do
        FactoryBot.create(:point_ledger, user: user, points: 50, created_at: date.beginning_of_month + 1.day)
      end

      it 'returns false' do
        expect(service.result).to be false
      end
    end

    context 'when user has points equal to threshold' do
      before do
        FactoryBot.create(:point_ledger, user: user, points: 100, created_at: date.beginning_of_month + 2.days)
      end

      it 'returns true' do
        expect(service.result).to be true
      end
    end

    context 'when user has points more than threshold' do
      before do
        FactoryBot.create(:point_ledger, user: user, points: 150, created_at: date.beginning_of_month + 3.days)
      end

      it 'returns true' do
        expect(service.result).to be true
      end
    end

    context 'when points are outside the month' do
      before do
        FactoryBot.create(:point_ledger, user: user, points: 200, created_at: date.prev_month)
      end

      it 'does not count points outside the month' do
        expect(service.result).to be false
      end
    end
  end

  describe '#reward_type' do
    it 'returns :free_coffee' do
      expect(service.reward_type).to eq(:free_coffee)
    end
  end

  describe '#reason' do
    it 'returns correct reason' do
      expect(service.reason).to eq('Monthly threshold')
    end
  end
end
