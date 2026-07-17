module Posts
  class DeleteService
    def initialize(post:, user:)
      @post = post
      @user = user
    end

    def call
      return unauthorized unless owner?

      post.update!(deleted_at: Time.current)

      ServiceResult.new(
        success: true,
        message: "Post deleted successfully."
      )
    rescue ActiveRecord::RecordInvalid => e
      ServiceResult.new(
        success: false,
        message: "Unable to delete post.",
        errors: e.record.errors
      )
    end

    private

    attr_reader :post, :user

    def owner?
      post.user_id == user.id
    end

    def unauthorized
      ServiceResult.new(
        success: false,
        message: "You are not authorized to delete this post."
      )
    end
  end
end