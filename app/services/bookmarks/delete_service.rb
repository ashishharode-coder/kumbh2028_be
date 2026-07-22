module Bookmarks
  class DeleteService
    def initialize(post:, user:)
      @post = post
      @user = user
    end

    def call
      return not_bookmarked unless bookmark

      bookmark.destroy!

      ServiceResult.new(
        success: true,
        message: "Bookmark removed successfully."
      )
    end

    private

    attr_reader :post, :user

    def bookmark
      @bookmark ||= post.bookmarks.find_by(user_id: user.id)
    end

    def not_bookmarked
      ServiceResult.new(
        success: false,
        message: "Post is not bookmarked."
      )
    end
  end
end