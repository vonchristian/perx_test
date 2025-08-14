module Users
  class AccumulatedPointsQuery
    THRESHOLD = 100

    def self.execute
      User
        .joins(:point_ledgers)
        .where(point_ledgers: { created_at: Time.zone.now.last_month.all_month })
        .group("users.id")
        .having("SUM(point_ledgers.points) >= ?", THRESHOLD)
        .where.not(id: rewarded_user_ids)
    end

    def self.rewarded_user_ids
      Reward
        .free_coffee
        .where(
          awarded_at: Date.current.all_month,
          reason: Reward::REASON_MONTHLY_ACCUMULATED_POINTS
        )
        .select(:user_id)
    end
  end
end
