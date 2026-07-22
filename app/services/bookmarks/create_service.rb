module Bookmarks
  class CreateService
    def initialize(post:, user:)
      @post = post
      @user = user
    end

    def call
      return already_bookmarked if bookmarked?

      bookmark = post.bookmarks.new(user: user)

      if bookmark.save
        success
      else
        failure(bookmark.errors)
      end
    end

    private

    attr_reader :post, :user

    def bookmarked?
      post.bookmarks.exists?(user_id: user.id)
    end

    def success
      ServiceResult.new(
        success: true,
        message: "Post bookmarked successfully."
      )
    end

    def already_bookmarked
      ServiceResult.new(
        success: false,
        message: "Post already bookmarked."
      )
    end

    def failure(errors)
      ServiceResult.new(
        success: false,
        message: "Unable to bookmark post.",
        errors: errors
      )
    end
  end
end