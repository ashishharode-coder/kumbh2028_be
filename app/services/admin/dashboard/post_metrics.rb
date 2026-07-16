module Admin
  module Dashboard
    class PostMetrics
      class << self
        def call
          {
            total: Post.count,
            today: Post.today.count,
            published: Post.published.count,
            draft: Post.draft.count,
            archived: Post.archived.count,
            recent: Post.recent
          }
        end
      end
    end
  end
end