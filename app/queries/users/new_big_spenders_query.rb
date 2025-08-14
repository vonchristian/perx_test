module Users
  class NewBigSpendersQuery
    THRESHOLD_CENTS = 100_000
    DAYS_WINDOW = 60

    def self.execute
      cutoff_date = Time.zone.now - DAYS_WINDOW.days

      User
        .joins(:purchases)
        .where("users.first_purchase_at >= ?", cutoff_date)
        .group("users.id")
        .having("SUM(purchases.amount_cents) > ?", THRESHOLD_CENTS)
        .where.not(id: rewarded_user_ids)
    end

    def self.rewarded_user_ids
      Reward
        .free_movie_tickets
        .where(reason: Reward::REASON_NEW_USER_BIG_SPENDER)
        .select(:user_id)
    end
  end
end
