module Admin
  module Dashboard
    class DashboardService
      class << self
        def call
          {
            users: UserMetrics.call,
            sessions: SessionMetrics.call,
            otps: OtpMetrics.call
          }
        end
      end
    end
  end
end