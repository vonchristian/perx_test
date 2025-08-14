class Reward < ApplicationRecord
  REASON_BIRTHDAY_MONTH = "Birthday month"
  REASON_MONTHLY_ACCUMULATED_POINTS = "Monthly accumulated points"
  REASON_NEW_USER_BIG_SPENDER = "Big Spender"

  belongs_to :user

  enum :reward_type, { free_coffee: "free_coffee", free_movie_tickets: "free_movie_tickets" }

  validates :reward_type, presence: true
  validates :awarded_at, presence: true
  validates :reason, presence: true
end
