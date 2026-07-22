module Comments
  class DeleteService
    def initialize(comment:, user:)
      @comment = comment
      @user = user
    end

    def call
      return unauthorized unless owner?

      comment.update!(deleted_at: Time.current)

      ServiceResult.new(
        success: true,
        message: "Comment deleted successfully."
      )
    end

    private

    attr_reader :comment, :user

    def owner?
      comment.user_id == user.id
    end

    def unauthorized
      ServiceResult.new(
        success: false,
        message: "You are not authorized to delete this comment."
      )
    end
  end
end