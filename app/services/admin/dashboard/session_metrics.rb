module Admin
  module Dashboard
    class SessionMetrics
      class << self
        def call
          {
            active: ApiSession.active.count,
            today: ApiSession.today.count,
            recent: ApiSession
                      .includes(:user)
                      .order(created_at: :desc)
                      .limit(10)
          }
        end
      end
    end
  end
end