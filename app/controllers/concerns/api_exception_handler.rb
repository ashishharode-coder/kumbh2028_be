module ApiExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      failure(
        message: "Record not found.",
        status: :not_found
      )
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      failure(
        message: "Validation failed.",
        errors: e.record.errors.to_hash,
        status: :unprocessable_entity
      )
    end

    rescue_from StandardError do |e|
      Rails.logger.error e.full_message

      failure(
        message: "Internal server error.",
        status: :internal_server_error
      )
    end

    rescue_from Api::TooManyOtpRequestsError do
      failure(
        message: "Too many OTP requests.",
        status: :too_many_requests
      )
    end
  end
end