module Api
  class BasePostForm < BaseForm
    attribute :title, :string
    attribute :description, :string
    attribute :post_type, :string
    attribute :priority, :string
    attribute :location, :string
    attribute :latitude
    attribute :longitude

    attr_accessor :media
    attr_accessor :remove_media_ids

    validates :post_type,
              inclusion: { in: Post.post_types.keys },
              allow_blank: true

    validates :priority,
              inclusion: { in: Post.priorities.keys },
              allow_blank: true
  end
end