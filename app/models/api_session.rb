class ApiSession < ApplicationRecord
	belongs_to :user

  before_validation :generate_token, on: :create

  validates :token, presence: true, uniqueness: true

  scope :active, -> {
    where("expires_at > ?", Time.current)
  }

  private

  def generate_token
    self.token ||= SecureRandom.hex(32)
  end
end
