# spec/services/rewards/award_spec.rb
require 'rails_helper'

RSpec.describe Rewards::Grant, type: :model do
  let(:user) { FactoryBot.create(:user) }

  before do
    # Stub the rules to control eligibility and reward details
    allow(Rewards::MonthlyFreeCoffee).to receive(:run).with(user: user).and_return(double(
      result: false,
      reward_type: :free_coffee,
      reason: 'Monthly threshold'
    ))
    allow(Rewards::BirthdayFreeCoffee).to receive(:run).with(user: user).and_return(double(
      result: false,
      reward_type: :free_coffee,
      reason: 'Birthday month'
    ))
    allow(Rewards::NewUserMovieTicket).to receive(:run).with(user: user).and_return(double(
      result: false,
      reward_type: :free_movie_tickets,
      reason: 'New user big spender'
    ))
  end

  subject(:service) { described_class.run(user: user) }

  it 'returns empty array when no rules are eligible' do
    expect(service.result).to eq([])
  end

  context 'when some rules are eligible' do
    before do
      allow(Rewards::MonthlyFreeCoffee).to receive(:run).with(user: user).and_return(double(
        result: true,
        reward_type: :free_coffee,
        reason: 'Monthly threshold'
      ))
      allow(Rewards::BirthdayFreeCoffee).to receive(:run).with(user: user).and_return(double(
        result: true,
        reward_type: :free_coffee,
        reason: 'Birthday month'
      ))
    end

    it 'returns correct rewards array' do
      expect(service.result).to match_array([
        { reward_type: :free_coffee, reason: 'Monthly threshold' },
        { reward_type: :free_coffee, reason: 'Birthday month' }
      ])
    end
  end
end
