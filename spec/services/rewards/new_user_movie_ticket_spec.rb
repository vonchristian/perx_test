# spec/services/rewards/new_user_movie_ticket_spec.rb
require 'rails_helper'

RSpec.describe Rewards::NewUserMovieTicket, type: :model do
  let(:user) { FactoryBot.create(:user, first_purchase_at: first_purchase_date) }
  let(:service) { described_class.run(user: user) }

  context 'when user has no first purchase date' do
    let(:first_purchase_date) { nil }

    it 'returns false for execute' do
      expect(service.result).to be false
    end
  end

  context 'when user first purchase is outside the 60 day window' do
    let(:first_purchase_date) { 100.days.ago }

    before do
      FactoryBot.create(:purchase, user: user, amount_cents: 2_000_000, created_at: first_purchase_date + 1.day)
    end

    it 'returns false' do
      expect(service.result).to be false
    end
  end

  context 'when user spends less than threshold in 60 days' do
    let(:first_purchase_date) { 30.days.ago }

    before do
      FactoryBot.create(:purchase, user: user, amount_cents: 500_00, created_at: first_purchase_date + 10.days)
    end

    it 'returns false' do
      expect(service.result).to be false
    end
  end

  context 'when user spends more than threshold in 60 days' do
    let(:first_purchase_date) { 30.days.ago }

    before do
      FactoryBot.create(:purchase, user: user, amount_cents: 1_200_00, created_at: first_purchase_date + 10.days)
    end

    it 'returns true' do
      expect(service.result).to be true
    end

    it 'returns correct reward_type' do
      expect(service.reward_type).to eq(:free_movie_tickets)
    end

    it 'returns correct reason' do
      expect(service.reason).to eq("New user big spender")
    end
  end
end
