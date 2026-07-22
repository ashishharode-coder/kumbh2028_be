class PostsQuery < BaseQuery
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 20

  def initialize(params)
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

  attr_reader :params

  def base_scope
    Post.active
        .includes(:user, media_attachments: :blob)
        .left_joins(:likes)
        .order(created_at: :desc)
  end
end