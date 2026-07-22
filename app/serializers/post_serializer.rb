class PostSerializer
  include Rails.application.routes.url_helpers

  def self.render(post, user: nil)
    new(post).render
  end

  def initialize(post, user: nil)
    @post = post
    @user = user
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
      bookmarked_by_current_user: bookmarked_by_current_user?(@post, @user),

      user: user_json,

      media: media_json,

      created_at: @post.created_at,
      updated_at: @post.updated_at
    }
  end

  private

  attr_reader :post, :user


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

  def bookmarked_by_current_user?(post, current_user)
    return false unless current_user

    post.bookmarks.any? do |bookmark|
      bookmark.user_id == current_user.id
    end
  end
end