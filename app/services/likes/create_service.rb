module Likes
  class CreateService
    def initialize(post:, user:)
      @post = post
      @user = user
    end

    def call
      return already_liked if liked?

      like = post.likes.new(user: user)

      if like.save
        success
      else
        failure(like.errors)
      end
    end

    private

    attr_reader :post, :user

    def liked?
      post.likes.exists?(user_id: user.id)
    end

    def success
      ServiceResult.new(
        success: true,
        message: "Post liked successfully."
      )
    end

    def already_liked
      ServiceResult.new(
        success: false,
        message: "Post already liked."
      )
    end

    def failure(errors)
      ServiceResult.new(
        success: false,
        message: "Unable to like post.",
        errors: errors
      )
    end
  end
end