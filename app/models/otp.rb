class Otp < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  scope :verified, -> {
    where.not(verified_at: nil)
  }

  scope :pending, -> {
    where(verified_at: nil)
  }

  scope :today, -> {
    where(created_at: Date.current.all_day)
  }

  def status
    return "Verified" if verified?

    return "Expired" if expired?

    "Pending"
  end

  def expired?
    expires_at.present? && expires_at < Time.current
  end
end