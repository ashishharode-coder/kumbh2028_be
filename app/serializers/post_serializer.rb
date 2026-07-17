class PostSerializer
  include Rails.application.routes.url_helpers

  def self.render(post)
    new(post).render
  end

  def initialize(post)
    @post = post
  end

  def render
    {
      id: @post.id,
      title: @post.title,
      description: @post.description,

      post_type: @post.post_type,
      priority: @post.priority,
      status: @post.status,

      location: @post.location,
      latitude: @post.latitude,
      longitude: @post.longitude,

      verified: @post.verified,

      likes_count: @post.likes_count,
      comments_count: @post.comments_count,
      shares_count: @post.shares_count,
      views_count: @post.views_count,

      published_at: @post.published_at,

      user: user_json,

      media: media_json,

      created_at: @post.created_at,
      updated_at: @post.updated_at
    }
  end

  private

  def user_json
    return nil unless @post.user

    {
      id: @post.user.id,
      name: @post.user.name,
      phone: @post.user.phone
    }
  end

  def media_json
    @post.media.map do |file|
      {
        id: file.id,
        filename: file.filename.to_s,
        content_type: file.content_type,
        byte_size: file.byte_size,
        url: rails_blob_url(file)
      }
    end
  end
end