module Api
  module V1
    class ApplicationController < ActionController::API
      include ApiResponse
      include ApiValidation
      include ApiExceptionHandler

      before_action :authenticate_user!

      private

      def authenticate_user!
        token = bearer_token

        @current_user =
          Api::ApiSessionManager.authenticate(token)

        return if @current_user

        failure(
          message: "Unauthorized",
          status: :unauthorized
        )
      end

      def current_user
        @current_user
      end

      def bearer_token
        request.authorization.to_s.split.last
      end
    end
  end
end