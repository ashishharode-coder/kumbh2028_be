module Api
  class OtpService
    def self.generate_for(user)

      recent_otps = user.otps.where(
        "created_at > ?",
        15.minutes.ago
      )

      if recent_otps.count >= 3
        raise Api::TooManyOtpRequestsError
      end

      # Invalidate previous active OTPs
      user.otps.active.update_all(
        verified_at: Time.current
      )

      otp = SecureRandom.random_number(1_000_000).to_s.rjust(6, "0")

      record = user.otps.create!(
        code_digest: digest(otp),
        expires_at: OTP_EXPIRY.from_now
      )

      SmsService.send_otp(
        phone: user.phone,
        otp: otp
      )

      record
    end

    def self.digest(code)
      Digest::SHA256.hexdigest(code)
    end
  end
end