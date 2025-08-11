class PointsCalculator < ActiveInteraction::Base
  STANDARD_POINTS_PER_100 = 10
  FOREIGN_PURCHASE_MULTIPLIER = 2
  MINIMUM_SPENT_AMOUNT = 100

  object :purchase

  def execute
    points = base_points
    points *= FOREIGN_PURCHASE_MULTIPLIER if purchase.foreign?
    points
  end

  private

  def base_points
    (purchase.amount.to_f / MINIMUM_SPENT_AMOUNT).floor * STANDARD_POINTS_PER_100
  end
end
