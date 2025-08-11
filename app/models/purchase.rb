class Purchase < ApplicationRecord
  monetize :amount_cents
  belongs_to :user

  validates :amount_cents, numericality: { greater_than: 0 }
  validates :currency, presence: true

  def foreign?(home_country: nil)
    country.present? && home_country.present? && country != home_country
  end
end
