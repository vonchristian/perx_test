module Purchases
  class Create < ActiveInteraction::Base
    object :user
    integer :amount_cents
    string :country
    string :currency, default: "USD"

    def execute
      amount = Money.new(amount_cents, currency)

      Purchase.create!(
        user: user,
        amount_cents: amount.cents,
        currency: currency,
        country: country
      )
    end
  end
end
