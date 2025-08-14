module Users
  class BirthdayQuery
    def self.execute
      User
        .where("EXTRACT(MONTH FROM birth_date) = ? AND EXTRACT(DAY FROM birth_date) = ?", Date.current.month, Date.current.day)
        .where.not(id: rewarded_user_ids)
    end

    def self.rewarded_user_ids
      Reward
        .free_coffee
        .where(awarded_at: Date.current.all_month, reason: Reward::REASON_BIRTHDAY_MONTH)
        .select(:user_id)
    end
  end
end
