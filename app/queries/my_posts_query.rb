class MyPostsQuery
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 20

  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    posts = Post
              .includes(:user, media_attachments: :blob)
              .where(user_id: user.id)
              .active
              .order(created_at: :desc)

    posts = filter_status(posts)
    posts = filter_post_type(posts)
    posts = filter_priority(posts)

    total_count = posts.count

    posts = posts.offset((page - 1) * per_page)
                 .limit(per_page)

    ServiceResult.new(
      success: true,
      data: posts,
      meta: {
        page: page,
        per_page: per_page,
        total_count: total_count,
        total_pages: (total_count.to_f / per_page).ceil
      }
    )
  end

  private

  attr_reader :user, :params

  def page
    (params[:page] || DEFAULT_PAGE).to_i
  end

  def per_page
    (params[:per_page] || DEFAULT_PER_PAGE).to_i
  end

  def filter_status(posts)
    return posts unless params[:status].present?

    posts.where(status: params[:status])
  end

  def filter_post_type(posts)
    return posts unless params[:post_type].present?

    posts.where(post_type: params[:post_type])
  end

  def filter_priority(posts)
    return posts unless params[:priority].present?

    posts.where(priority: params[:priority])
  end
end