module Api
  module V1
    class ApplicationController < ActionController::API
      before_action :authenticate_user!

      private

      def authenticate_user!
        token = bearer_token

        @current_user =
          Api::ApiSessionManager.authenticate(token)

        render_unauthorized unless @current_user
      end

      def current_user
        @current_user
      end

      def bearer_token
        request.authorization.to_s.split.last
      end

      def render_unauthorized
        render json: {
          success: false,
          message: "Unauthorized"
        }, status: :unauthorized
      end
    end
  end
end