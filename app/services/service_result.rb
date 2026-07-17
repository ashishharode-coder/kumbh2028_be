class ServiceResult
  attr_reader :data, :errors, :message, :meta

  def initialize(success:, data: nil, errors: {}, message: nil, meta: {})
    @success = success
    @data = data
    @errors = errors
    @message = message
    @meta = meta
  end

  def success?
    @success
  end

  def failure?
    !@success
  end
end