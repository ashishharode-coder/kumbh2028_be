class Comment < ApplicationRecord

  belongs_to :post, counter_cache: true
  belongs_to :user

  belongs_to :parent,
             class_name: "Comment",
             optional: true

  has_many :replies,
           class_name: "Comment",
           foreign_key: :parent_id,
           dependent: :destroy

  validates :content, presence: true

  scope :active, -> { where(deleted_at: nil) }
  scope :root, -> { where(parent_id: nil) }
end
