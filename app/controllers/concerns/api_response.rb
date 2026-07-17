module ApiResponse
  extend ActiveSupport::Concern

  private

  def success(message: "Success", data: nil, meta: {}, status: :ok)
    render json: {
      success: true,
      message: message,
      errors: {},
      data: data,
      meta: meta
    }, status: status
  end

  def failure(message:, errors: {}, status: :unprocessable_entity)
    render json: {
      success: false,
      message: message,
      errors: errors,
      data: nil,
      meta: {}
    }, status: status
  end
end