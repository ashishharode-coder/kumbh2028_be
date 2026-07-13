module Api
  module V1
    class UsersController < ApplicationController
      def me
        success(
          data: {
            user: {
              id: current_user.id,
              name: current_user.name,
              email: current_user.email,
              phone: current_user.phone
            }
          }
        )
      end

      def logout
        Api::ApiSessionManager.sign_out(bearer_token)

        success(
          message: "Logged out successfully."
        )
      end
    end
  end
end