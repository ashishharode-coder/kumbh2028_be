module Api
  module V1
    class BookmarksController < ApplicationController
      def create
        post_result = PostQuery.new(params[:post_id]).call

        return failure(
          message: post_result.message,
          status: :not_found
        ) unless post_result.success?

        result = Bookmarks::CreateService.new(
          post: post_result.data,
          user: current_user
        ).call

        if result.success?
          success(message: result.message)
        else
          failure(
            message: result.message,
            errors: result.errors
          )
        end
      end

      def destroy
        post_result = PostQuery.new(params[:post_id]).call

        return failure(
          message: post_result.message,
          status: :not_found
        ) unless post_result.success?

        result = Bookmarks::DeleteService.new(
          post: post_result.data,
          user: current_user
        ).call

        if result.success?
          success(message: result.message)
        else
          failure(message: result.message)
        end
      end
    end
  end
end