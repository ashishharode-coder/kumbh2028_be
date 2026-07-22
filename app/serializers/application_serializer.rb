class ApplicationSerializer
  class << self
    def format_datetime(datetime)
      datetime&.iso8601
    end
  end
end