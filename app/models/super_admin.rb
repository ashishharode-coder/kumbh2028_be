class SuperAdmin < ApplicationRecord

  has_secure_password

  has_many :sessions,
           as: :authenticatable,
           dependent: :destroy

  before_validation :normalize_email

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end