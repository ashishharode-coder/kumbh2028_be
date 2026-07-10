class Current < ActiveSupport::CurrentAttributes
  attribute :session

  delegate :authenticatable, to: :session, allow_nil: true

  # attribute :actor
  # attribute :super_admin
end
