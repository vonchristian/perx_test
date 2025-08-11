class User < ApplicationRecord
  has_many :purchases
  has_many :point_ledgers
end
