class ApiSession < ApplicationRecord
  belongs_to :user

  before_validation :generate_token, on: :create

  validates :token, presence: true, uniqueness: true

  scope :active, -> {
    where("expires_at > ?", Time.current)
  }

  scope :recent, -> {
    order(last_seen_at: :desc)
  }

  scope :today, -> {
    where(created_at: Date.current.all_day)
  }

  def expired?
    expires_at.present? && expires_at <= Time.current
  end

  private

  def generate_token
    self.token ||= SecureRandom.hex(32)
  end
end