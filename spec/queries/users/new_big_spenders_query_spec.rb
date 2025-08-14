# spec/queries/users/new_big_spenders_query_spec.rb
require "rails_helper"

RSpec.describe Users::NewBigSpendersQuery do
  describe ".execute" do
    let(:threshold_cents) { described_class::THRESHOLD_CENTS }
    let(:days_window) { described_class::DAYS_WINDOW }
    let(:cutoff_date) { Time.zone.now - days_window.days }

    let!(:eligible_user) do
      FactoryBot.create(:user, first_purchase_at: 10.days.ago).tap do |user|
         FactoryBot.create(:purchase, user:, amount_cents: threshold_cents + 1)
      end
    end

    let!(:below_threshold_user) do
      FactoryBot.create(:user, first_purchase_at: 10.days.ago).tap do |user|
        FactoryBot.create(:purchase, user:, amount_cents: threshold_cents - 1)
      end
    end

    let!(:old_user) do
      FactoryBot.create(:user, first_purchase_at: 100.days.ago).tap do |user|
        FactoryBot.create(:purchase, user:, amount_cents: threshold_cents + 10)
      end
    end

    let!(:already_rewarded_user) do
      FactoryBot.create(:user, first_purchase_at: 10.days.ago).tap do |user|
        FactoryBot.create(:purchase, user:, amount_cents: threshold_cents + 50)
        FactoryBot.create(:reward,
               user:,
               reward_type: 'free_movie_tickets',
               reason: Reward::REASON_NEW_USER_BIG_SPENDER,
               awarded_at: Time.zone.now)
      end
    end

    let(:result) { described_class.execute }

    it { expect(result).to include(eligible_user) }
    it { expect(result).to_not include(below_threshold_user) }
    it { expect(result).to_not include(old_user) }
    it { expect(result).to_not include(already_rewarded_user) }
  end
end
