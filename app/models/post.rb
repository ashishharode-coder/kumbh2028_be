class Post < ApplicationRecord
  belongs_to :user


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
    rejected: 3
  }

  enum :priority, {
    low: 0,
    medium: 1,
    high: 2,
    critical: 3
  }

  scope :recent, -> {
    order(created_at: :desc)
  }

  scope :today, -> {
    where(created_at: Date.current.all_day)
  }

end
