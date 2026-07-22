# app/queries/bookmarked_posts_query.rb

class BookmarkedPostsQuery < BaseQuery
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    scope = bookmarked_posts

    posts = paginate(scope)

    ServiceResult.new(
      success: true,
      data: posts,
      meta: meta(scope)
    )
  end

  private

  attr_reader :user, :params

  def bookmarked_posts
    Post.active
        .joins(:bookmarks)
        .where(bookmarks: { user_id: user.id })
        .includes(
          :user,
          :comments,
          :likes,
          :bookmarks,
          media_attachments: :blob
        )
        .distinct
        .order(created_at: :desc)
  end
end