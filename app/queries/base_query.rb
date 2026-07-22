class BaseQuery
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 20
  MAX_PER_PAGE = 100

  private

  def paginate(scope)
    scope.offset((page - 1) * per_page)
         .limit(per_page)
  end

  def meta(scope)
    total_count = scope.count

    {
      page: page,
      per_page: per_page,
      total_count: total_count,
      total_pages: (total_count.to_f / per_page).ceil
    }
  end

  def page
    [params.fetch(:page, DEFAULT_PAGE).to_i, 1].max
  end

  def per_page
    value = params.fetch(:per_page, DEFAULT_PER_PAGE).to_i
    value = DEFAULT_PER_PAGE if value <= 0
    [value, MAX_PER_PAGE].min
  end
end