class SessionManager
  COOKIE_NAME = :admin_session_token

  class << self
    def sign_in(cookies:, request:, super_admin:)
      session = super_admin.sessions.create!(
        ip_address: request.remote_ip,
        user_agent: request.user_agent,
        last_seen_at: Time.current,
        expires_at: API_SESSION_EXPIRY.from_now
      )

      cookies.signed.permanent[COOKIE_NAME] = {
        value: session.token,
        httponly: true,
        same_site: :lax
      }

      Current.session = session
    end

    def sign_out(cookies:)
      token = cookies.signed[COOKIE_NAME]

      Session.find_by(token: token)&.destroy if token.present?

      cookies.delete(COOKIE_NAME)

      Current.reset
    end

    def resume(cookies:)
      token = cookies.signed[COOKIE_NAME]
      return unless token

      session = Session.active.find_by(token: token)
      return unless session

      Current.session = session
      session.update_column(:last_seen_at, Time.current)
    end
  end
end