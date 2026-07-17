module Api
  class CreatePostForm < BasePostForm
    validates :title, presence: true
    validates :description, presence: true
    validates :post_type, presence: true
    validates :priority, presence: true
  end
end