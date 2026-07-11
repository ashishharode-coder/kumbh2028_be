module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_user!,
                         only: %i[
                           send_otp
                           verify_otp
                         ]

      def send_otp
        user = User.find_or_create_by!(phone: params[:phone])

        Api::OtpService.generate_for(user)

        render json: {
          success: true,
          message: "OTP sent successfully."
        }
      end

      def verify_otp
        user = User.find_by(phone: params[:phone])

        unless user
          return render json: {
            success: false,
            message: "User not found."
          }, status: :unprocessable_entity
        end

        verified =
          Api::OtpVerifier.verify(
            user: user,
            otp: params[:otp]
          )

        unless verified
          return render json: {
            success: false,
            message: "Invalid OTP."
          }, status: :unprocessable_entity
        end

        session =
          Api::ApiSessionManager.sign_in(
            user: user,
            request: request,
            device_params: {
              device_id: params[:device_id],
              device_name: params[:device_name],
              platform: params[:platform]
            }
          )

        render json: {
          success: true,
          token: session.token,
          user: {
            id: user.id,
            name: user.name,
            phone: user.phone
          }
        }
      end
    end
  end
end