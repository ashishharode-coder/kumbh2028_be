module Api
  module V1
    class UsersController < ApplicationController
      def me
        render json: {
          success: true,
          user: {
            id: current_user.id,
            name: current_user.name,
            phone: current_user.phone,
            email: current_user.email
          }
        }
      end

      def logout
        Api::ApiSessionManager.sign_out(
          bearer_token
        )

        render json: {
          success: true,
          message: "Logged out successfully."
        }
      end
    end
  end
end