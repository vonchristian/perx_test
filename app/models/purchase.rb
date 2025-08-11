class Purchase < ApplicationRecord
  monetize :amount_cents
  belongs_to :user

  validates :amount_cents, numericality: { greater_than: 0 }
  validates :currency, presence: true

  def foreign?
    country.present? && country != user.country
  end
end
