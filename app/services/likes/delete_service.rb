module Likes
  class DeleteService
    def initialize(post:, user:)
      @post = post
      @user = user
    end

    def call
      return not_liked unless like

      like.destroy!

      ServiceResult.new(
        success: true,
        message: "Post unliked successfully."
      )
    end

    private

    attr_reader :post, :user

    def like
      @like ||= post.likes.find_by(user_id: user.id)
    end

    def not_liked
      ServiceResult.new(
        success: false,
        message: "Post is not liked."
      )
    end
  end
end