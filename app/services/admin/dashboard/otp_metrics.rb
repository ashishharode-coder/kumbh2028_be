module Admin
  module Dashboard
    class OtpMetrics
      class << self
        def call
          {
            today: Otp.today.count,
            verified: Otp.verified.today.count
          }
        end
      end
    end
  end
end