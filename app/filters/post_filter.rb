class PostFilter
  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def call
    filter_status
    filter_priority
    filter_post_type
    search

    scope
  end

  private

  attr_reader :params
  attr_accessor :scope

  def filter_status
    return if params[:status].blank?

    self.scope = scope.where(status: params[:status])
  end

  def filter_priority
    return if params[:priority].blank?

    self.scope = scope.where(priority: params[:priority])
  end

  def filter_post_type
    return if params[:post_type].blank?

    self.scope = scope.where(post_type: params[:post_type])
  end

  def search
    return if params[:search].blank?

    query = "%#{params[:search]}%"

    self.scope = scope.where(
      "title ILIKE :query OR description ILIKE :query",
      query: query
    )
  end
end