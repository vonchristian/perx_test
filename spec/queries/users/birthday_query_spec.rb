# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::BirthdayQuery, type: :query do
  describe '.call' do
    let(:current_month) { Date.current.month }
    let(:current_day) { Date.current.day }
    let!(:birthday_today_user) { FactoryBot.create(:user, birth_date: Date.new(1990, current_month, current_day)) }
    let!(:birthday_next_month_user) { FactoryBot.create(:user, birth_date: Date.new(1990, current_month + 1, current_day)) }
    let(:result) { described_class.execute }

    context 'when user has not received free coffee this month' do
      it { expect(result).to include(birthday_today_user) }
    end

    context 'when user has already received free coffee this month' do
      before do
        FactoryBot.create(:reward, reward_type: 'free_coffee', reason: Reward::REASON_BIRTHDAY_MONTH, user: birthday_today_user, awarded_at: Date.current.beginning_of_month.beginning_of_day)
      end

      it { expect(result).not_to include(birthday_today_user) }
    end

    describe 'does not include users with birthdays in other months' do
      it { expect(result).to_not include(birthday_next_month_user) }
    end
  end
end
