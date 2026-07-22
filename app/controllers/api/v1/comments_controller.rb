module Api
  module V1
    class CommentsController < ApplicationController

      def index
        post_result = PostQuery.new(params[:post_id]).call

        return failure(
          message: post_result.message,
          status: :not_found
        ) unless post_result.success?

        result = CommentsQuery.new(
          post: post_result.data,
          params: params
        ).call

        success(
          message: "Comments fetched successfully.",
          data: CommentsSerializer.render(
            result.data,
            current_user: current_user
          ),
          meta: result.meta
        )
      end


      def create
        post_result = PostQuery.new(params[:post_id]).call

        unless post_result.success?
          return failure(
            message: post_result.message,
            status: :not_found
          )
        end

        form = Api::CreateCommentForm.new(comment_params)

        result = Comments::CreateService.new(
          post: post_result.data,
          user: current_user,
          form: form
        ).call

        if result.success?
          success(
            message: result.message,
            data: CommentSerializer.render(result.data, current_user: current_user)
          )
        else
          failure(
            message: result.message,
            errors: result.errors
          )
        end
      end


      def update
        comment_result = CommentQuery.new(params[:id]).call

        return failure(
          message: comment_result.message,
          status: :not_found
        ) unless comment_result.success?

        form = Api::UpdateCommentForm.new(comment_params)

        result = Comments::UpdateService.new(
          comment: comment_result.data,
          user: current_user,
          form: form
        ).call

        if result.success?
          success(
            message: result.message,
            data: CommentSerializer.render(
              result.data,
              current_user: current_user
            )
          )
        else
          failure(
            message: result.message,
            errors: result.errors
          )
        end
      end

      private

      def comment_params
        params.permit(:content, :parent_id)
      end
    end
  end
end