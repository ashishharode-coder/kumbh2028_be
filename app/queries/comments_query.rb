class CommentsQuery < BaseQuery
  def initialize(post:, params:)
    @post = post
    @params = params
  end

  def call
    comments = base_scope

    ServiceResult.new(
      success: true,
      data: comments,
      meta: {
        total_comments: comments.size
      }
    )
  end

  private

  attr_reader :post

  def base_scope
    post.comments
        .active
        .includes(:user)
        .order(created_at: :asc)
  end
end