# spec/queries/users/accumulated_points_query_spec.rb
require "rails_helper"

RSpec.describe Users::AccumulatedPointsQuery do
  describe ".execute" do
    let(:threshold) { Users::AccumulatedPointsQuery::THRESHOLD }
    let(:last_month) { Time.zone.now.last_month }
    let(:this_month) { Time.zone.now }

    let!(:eligible_user) do
      FactoryBot.create(:user).tap do |user|
        FactoryBot.create(:point_ledger, user:, points: threshold, created_at: last_month)
      end
    end

    let!(:below_threshold_user) do
      FactoryBot.create(:user).tap do |user|
        FactoryBot.create(:point_ledger, user:, points: threshold - 1, created_at: last_month)
      end
    end

    let!(:no_points_last_month_user) { FactoryBot.create(:user) }

    let!(:already_rewarded_user) do
      FactoryBot.create(:user).tap do |user|
        FactoryBot.create(:point_ledger, user:, points: threshold + 10, created_at: last_month)
        FactoryBot.create(:reward, :free_coffee,
               user:,
               reason: Reward::REASON_MONTHLY_ACCUMULATED_POINTS,
               awarded_at: this_month)
      end
    end

    let(:result) { described_class.execute }

    it { expect(result).to include(eligible_user) }
    it { expect(result).not_to include(below_threshold_user) }
    it { expect(result).not_to include(no_points_last_month_user) }
    it { expect(result).not_to include(already_rewarded_user) }
  end
end
