class Session < ApplicationRecord
  belongs_to :authenticatable, polymorphic: true

  before_validation :generate_token, on: :create

  validates :token, presence: true, uniqueness: true

  scope :active, -> {
    where("expires_at IS NULL OR expires_at > ?", Time.current)
  }

  def expired?
    expires_at.present? && expires_at < Time.current
  end

  private

  def generate_token
    self.token ||= SecureRandom.hex(32)
  end
end