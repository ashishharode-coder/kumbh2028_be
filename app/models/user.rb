class User < ApplicationRecord
  has_many :otps, dependent: :destroy
  has_many :api_sessions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy



  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :phone, presence: true, uniqueness: true

  enum :status,
   {
     active: 0,
     blocked: 1
   },
   default: :active

  scope :active, -> { where(active: true) }
  
  scope :recent,
        -> { order(created_at: :desc) }

  scope :today, -> {
    where(created_at: Date.current.all_day)
  }


  def active_sessions_count
    api_sessions.active.count
  end

  def total_sessions_count
    api_sessions.count
  end

  def last_login_at
    api_sessions.maximum(:last_seen_at)
  end

  def otp_requests_count
    otps.count
  end

  def last_otp_sent_at
    otps.maximum(:created_at)
  end

  def logout_everywhere!
    api_sessions.delete_all
  end

  def recent_sessions(limit = 10)
    api_sessions
      .recent
      .limit(limit)
  end

  def recent_otps(limit = 10)
    otps
      .recent
      .limit(limit)
  end
end
