class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  has_many_attached :media do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, 300]
    attachable.variant :medium, resize_to_limit: [800, 800]
  end

  validates :description,
            presence: true
	
	enum :post_type, {
    alert: 0,
    updates: 1,
    event: 2,
    announcement: 3,
    service: 4
  }

  enum :status, {
    draft: 0,
    published: 1,
    archived: 2,
    rejected: 3,
    pending: 4
  }

  enum :priority, {
    low: 0,
    medium: 1,
    high: 2,
    critical: 3
  }

  scope :active, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  scope :recent, -> {
    order(created_at: :desc)
  }

  scope :today, -> {
    where(created_at: Date.current.all_day)
  }

  def deleted?
    deleted_at.present?
  end

  def self.liked?(post, current_user)
    return false unless current_user

    post.likes.any? { |like| like.user_id == current_user.id }
  end

end
