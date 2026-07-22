class LikedPostsQuery < BaseQuery
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    scope = Post.active
                .includes(
                  :user,
                  :likes,
                  media_attachments: :blob
                )
                .joins(:likes)
                .where(likes: { user_id: user.id })
                .distinct
                .order(created_at: :desc)

    posts = paginate(scope)

    ServiceResult.new(
      success: true,
      data: posts,
      meta: meta(scope)
    )
  end

  private

  attr_reader :user, :params
end