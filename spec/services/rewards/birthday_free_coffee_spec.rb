# spec/services/rewards/birthday_free_coffee_spec.rb
require 'rails_helper'

RSpec.describe Rewards::BirthdayFreeCoffee, type: :model do
  let(:user) { FactoryBot.create(:user, birth_date: birth_date) }
  let(:birth_date) { Time.zone.now.change(day: 15).to_date }

  subject(:service) { described_class.run(user: user) }

  context 'when user birthday is in the current month' do
    it 'returns true' do
      expect(service.result).to be true
    end
  end

  context 'when user birthday is not in the current month' do
    let(:birth_date) { Time.zone.now.prev_month.change(day: 15).to_date }

    it 'returns false' do
      expect(service.result).to be false
    end
  end

  context 'when user birth_date is nil' do
    let(:birth_date) { nil }

    it 'returns false' do
      expect(service.result).to be false
    end
  end

  describe '#reward_type' do
    it 'returns :free_coffee' do
      expect(service.reward_type).to eq(:free_coffee)
    end
  end

  describe '#reason' do
    it 'returns "Birthday month"' do
      expect(service.reason).to eq("Birthday month")
    end
  end
end
