class User < ApplicationRecord
  # has_secure_password
  # has_many :sessions, dependent: :destroy
  has_many :otps, dependent: :destroy
  has_many :api_sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :phone, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }
end
