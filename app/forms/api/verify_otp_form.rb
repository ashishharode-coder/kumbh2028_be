module Api
  class VerifyOtpForm
    include ActiveModel::Model

    attr_accessor :phone,
                  :otp,
                  :device_id,
                  :device_name,
                  :platform

    validates :phone, presence: true
    validates :otp,
              presence: true,
              length: { is: 6 }
  end
end