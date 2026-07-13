module Api
  class SendOtpForm
    include ActiveModel::Model

    attr_accessor :phone

    validates :phone,
              presence: true,
              format: {
                with: /\A[6-9]\d{9}\z/,
                message: "must be a valid 10 digit mobile number"
              }
  end
end