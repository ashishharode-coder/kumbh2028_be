module Api
  class OtpVerifier
    MAX_ATTEMPTS = 5

    def self.verify(user:, otp:)
      record = user.otps.active.order(created_at: :desc).first

      return false unless record

      return false if record.attempts >= MAX_ATTEMPTS

      record.increment!(:attempts)

      if record.code_digest == OtpService.digest(otp)
        record.update!(verified_at: Time.current)
        true
      else
        false
      end
    end
  end
end