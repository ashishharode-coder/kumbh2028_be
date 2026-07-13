module Admin
  class UserSessionService
    class << self

      def terminate(session)
        session.destroy!
      end

      def terminate_all(user)
        user.api_sessions.destroy_all
      end

    end
  end
end