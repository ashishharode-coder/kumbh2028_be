class PostsQuery
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 20

  def initialize(params)
    @params = params
  end

  def call
    ServiceResult.new(
      success: true,
      data: paginated_posts,
      meta: pagination_meta
    )
  end

  private

  attr_reader :params

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

  def filter_verified(posts)
    return posts unless params[:verified].present?

    posts.where(verified: ActiveModel::Type::Boolean.new.cast(params[:verified]))
  end

  def search(posts)
    return posts unless params[:search].present?

    q = "%#{params[:search]}%"

    posts.where(
      "title ILIKE :q
       OR description ILIKE :q
       OR location ILIKE :q",
      q: q
    )
  end

  def paginate(posts)
    page = (params[:page] || DEFAULT_PAGE).to_i
    per_page = (params[:per_page] || DEFAULT_PER_PAGE).to_i

    posts.offset((page - 1) * per_page)
         .limit(per_page)
  end



  def scope
    @scope ||= begin
      posts = Post.active.includes(:user, media_attachments: :blob)
                  .order(priority: :desc, created_at: :desc)

      posts = filter_status(posts)
      posts = filter_post_type(posts)
      posts = filter_priority(posts)
      posts = filter_verified(posts)
      search(posts)
    end
  end



  def paginated_posts
    scope.offset((page - 1) * per_page).limit(per_page)
  end

  def pagination_meta
    {
      page: page,
      per_page: per_page,
      total_count: scope.count,
      total_pages: (scope.count.to_f / per_page).ceil
    }
  end

  def page
    @page ||= (params[:page] || DEFAULT_PAGE).to_i
  end

  def per_page
    @per_page ||= (params[:per_page] || DEFAULT_PER_PAGE).to_i
  end
end