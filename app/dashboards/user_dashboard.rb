require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    phone: Field::String,
    email: Field::String,
    status: Field::Select,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    name
    phone
    status
    created_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    phone
    email
    status
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    phone
    email
    status
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(user)
    "#{user.name.presence || 'Unknown'} (#{user.phone})"
  end
end