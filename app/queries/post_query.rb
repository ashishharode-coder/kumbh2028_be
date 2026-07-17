class PostQuery
  def initialize(id)
    @id = id
  end

  def call
    post = Post.active
             .includes(:user, media_attachments: :blob)
             .find_by(id: @id)

    return failure("Post not found.") unless post

    success(post)
  end

  private

  def success(post)
    ServiceResult.new(
      success: true,
      data: post
    )
  end

  def failure(message)
    ServiceResult.new(
      success: false,
      message: message
    )
  end
end