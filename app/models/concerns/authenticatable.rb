module Authenticatable
  extend ActiveSupport::Concern

  included do
    has_secure_password

    before_validation :normalize_login

    validates :password,
              length: { minimum: 8 },
              allow_nil: true
  end

  private

  def normalize_login
    self.email = email.to_s.strip.downcase if respond_to?(:email)
    self.phone = phone.to_s.strip if respond_to?(:phone)
  end
end