module Admin
  module Dashboard
    class UserMetrics
      class << self
        def call
          {
            total: User.count,
            today: User.today.count,
            blocked: User.blocked.count,
            recent: User.order(created_at: :desc).limit(5)
          }
        end
      end
    end
  end
end