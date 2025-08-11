class PointLedger < ApplicationRecord
  belongs_to :user
  belongs_to :purchase

  validates :points, presence: true, numericality: { only_integer: true }
  validates :reason, presence: true

  def self.total_points_for_month(date)
    where(created_at: date.beginning_of_month..date.end_of_month).sum(:points)
  end
end
