module Admin
  class UserTimelineService
    class << self

      def build(user)
        events = []

        user.api_sessions.find_each do |session|

          events << {
            at: session.created_at,
            title: "Logged in",
            description:
              "#{session.platform} - #{session.device_name}"
          }

        end

        user.otps.verified.find_each do |otp|

          events << {
            at: otp.verified_at,
            title: "OTP Verified",
            description: nil
          }

        end

        events.sort_by { |e| e[:at] }.reverse

      end

    end
  end
end