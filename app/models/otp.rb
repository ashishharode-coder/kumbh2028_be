class Otp < ApplicationRecord
	belongs_to :user

  scope :active, -> {
    where(verified_at: nil)
      .where("expires_at > ?", Time.current)
  }

  def expired?
    expires_at <= Time.current
  end

  def verified?
    verified_at.present?
  end
end
