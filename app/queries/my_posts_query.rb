class MyPostsQuery < BaseQuery

  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    posts = PostFilter.new(base_scope, params).call
    ServiceResult.new(
      success: true,
      data: paginate(posts),
      meta: meta(posts)
    )
  end

  private

  attr_reader :user, :params

  def base_scope
    Post.active
        .where(user: user)
        .includes(:user, media_attachments: :blob)
        .order(created_at: :desc)
  end
end