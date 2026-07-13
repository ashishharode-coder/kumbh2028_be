module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_user!,
                         only: %i[send_otp resend_otp verify_otp]

      def send_otp
        form = Api::SendOtpForm.new(
          phone: Api::PhoneNormalizer.normalize(params[:phone])
        )

        return unless validate_form(form)

        user = User.find_or_create_by!(phone: form.phone)

        Api::OtpService.generate_for(user)

        success(
          message: "OTP sent successfully."
        )
      end

      def resend_otp
        form = Api::SendOtpForm.new(
          phone: Api::PhoneNormalizer.normalize(params[:phone])
        )

        return unless validate_form(form)

        user = User.find_by(phone: form.phone)

        return failure(message: "User not found.") unless user

        Api::OtpService.generate_for(user)

        success(
          message: "OTP resent."
        )
      end

      def verify_otp
        form = Api::VerifyOtpForm.new(
          phone: Api::PhoneNormalizer.normalize(params[:phone]),
          otp: params[:otp],
          device_id: params[:device_id],
          device_name: params[:device_name],
          platform: params[:platform]
        )

        return unless validate_form(form)

        user = User.find_by(phone: form.phone)

        return failure(message: "User not found.") unless user
        return failure(message: "Your account has been blocked.")if user.blocked?

        verified =
          Api::OtpVerifier.verify(
            user: user,
            otp: form.otp
          )

        return failure(message: "Invalid OTP.") unless verified

        session =
          Api::ApiSessionManager.sign_in(
            user: user,
            request: request,
            device_params: {
              device_id: form.device_id,
              device_name: form.device_name,
              platform: form.platform
            }
          )

        success(
          message: "Login successful.",
          data: {
            token: session.token,
            user: {
              id: user.id,
              name: user.name,
              phone: user.phone
            }
          }
        )
      end
    end
  end
end