class Reward < ApplicationRecord
  belongs_to :user

  enum :reward_type, { free_coffee: "free_coffee", free_movie_tickets: "free_movie_tickets" }

  validates :reward_type, presence: true
  validates :awarded_at, presence: true
  validates :reason, presence: true
end
