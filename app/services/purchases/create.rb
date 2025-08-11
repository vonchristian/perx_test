module Purchases
  class Create < ActiveInteraction::Base
    object :user
    integer :amount_cents
    string :country
    string :currency, default: "USD"

    def execute
      amount = Money.new(amount_cents, currency)

      purchase = Purchase.create!(
        user: user,
        amount_cents: amount.cents,
        currency: currency,
        country: country
      )

      points = calculate_points(purchase)
      create_point_ledger(points: points, purchase: purchase) if points.positive?
      purchase
    end

    private

    def calculate_points(purchase)
      PointsCalculator.run!(purchase: purchase)
    end

    def create_point_ledger(points:, purchase:)
      PointLedger.create!(
        user: user,
        purchase: purchase,
        points: points,
        reason: "new purchase"
      )
    end
  end
end
