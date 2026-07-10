class Post < ApplicationRecord
	has_many_attached :media
	
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
    archived: 2
  }

  enum :priority, {
    low: 0,
    medium: 1,
    high: 2,
    critical: 3
  }
end
