class PointLedger < ApplicationRecord
  belongs_to :user
  belongs_to :purchase

  validates :points, presence: true, numericality: { only_integer: true }
  validates :reason, presence: true
end
