module Api
  class ApiSessionManager
    SESSION_EXPIRY = 30.days

    class << self

      def sign_in(user:, request:, device_params: {})
        ApiSession.create!(
          user: user,
          ip_address: request.remote_ip,
          device_id: device_params[:device_id],
          device_name: device_params[:device_name],
          platform: device_params[:platform],
          last_seen_at: Time.current,
          expires_at: SESSION_EXPIRY.from_now
        )
      end

      def authenticate(token)
        session = ApiSession.active.find_by(token: token)

        return nil unless session

        session.update_column(:last_seen_at, Time.current)

        session.user
      end

      def sign_out(token)
        ApiSession.find_by(token: token)&.destroy
      end
      
    end
  end
end