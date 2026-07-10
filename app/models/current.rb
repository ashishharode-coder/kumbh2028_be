class Current < ActiveSupport::CurrentAttributes
  attribute :session

  delegate :authenticatable, to: :session, allow_nil: true
end