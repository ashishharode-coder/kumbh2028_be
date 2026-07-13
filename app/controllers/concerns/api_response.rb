module ApiResponse
  extend ActiveSupport::Concern

  private

  def success(message: "Success", data: nil, status: :ok)
    render json: {
      success: true,
      message: message,
      errors: {},
      data: data
    }, status: status
  end

  def failure(message:, errors: {}, status: :unprocessable_entity)
    render json: {
      success: false,
      message: message,
      errors: errors,
      data: nil
    }, status: status
  end
end