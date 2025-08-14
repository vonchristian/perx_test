# spec/interactions/rewards/award_birthday_free_coffee_spec.rb
require 'rails_helper'

RSpec.describe Rewards::AwardBirthdayFreeCoffee, type: :service do
  describe '#execute' do
    let(:user) { FactoryBot.create(:user, birth_date: Date.new(1990, Time.zone.now.month, Time.zone.now.day)) }

    it 'creates a free coffee reward for the user' do
      expect {
        described_class.run!(user: user)
      }.to change { user.rewards.free_coffee.count }.by(1)
    end

    describe 'sets the correct reward attributes' do
      before { described_class.run!(user: user) }
      let(:reward) { user.rewards.last }

      it { expect(reward.reward_type).to eq('free_coffee') }
      it { expect(reward.reason).to eq(Reward::REASON_BIRTHDAY_MONTH) }
      it { expect(reward.awarded_at).to be_within(1.second).of(Time.zone.now) }
    end
  end
end
