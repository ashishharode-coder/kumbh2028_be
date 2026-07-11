module Api
  class SmsService
    def self.send_otp(phone:, otp:)
      Rails.logger.info "======================================="
      Rails.logger.info "OTP for #{phone} : #{otp}"
      Rails.logger.info "======================================="
    end
  end
end