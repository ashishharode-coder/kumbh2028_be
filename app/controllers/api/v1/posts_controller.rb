module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user!

      def index
        result = PostsQuery.new(params).call

        success(
          message: "Posts fetched successfully.",
          data: PostsSerializer.render(result.data),
          meta: result.meta
        )
      end

      def show
        result = PostQuery.new(params[:id]).call

        if result.success?
          success(
            message: "Post fetched successfully.",
            data: PostSerializer.render(result.data)
          )
        else
          failure(
            message: result.message,
            status: :not_found
          )
        end
      end

      def my_posts
        result = MyPostsQuery.new(
          user: current_user,
          params: params
        ).call

        success(
          message: "Posts fetched successfully.",
          data: PostsSerializer.render(result.data),
          meta: result.meta
        )
      end

      def create
        form = Api::CreatePostForm.new(post_params)
        result = Posts::CreateService.new(
          current_user,
          form
        ).call

        if result.success?
          success(
            message: "Post created successfully.",
            data: PostSerializer.render(result.data),
            status: :created
          )
        else
          failure(
            message: "Validation failed.",
            errors: result.errors
          )
        end
      end


      def update
        query = PostQuery.new(params[:id]).call

        unless query.success?
          return failure(
            message: query.message,
            status: :not_found
          )
        end

        form = Api::UpdatePostForm.new(post_params)

        form.media = params[:media]
        form.remove_media_ids = params[:remove_media_ids]

        result = Posts::UpdateService.new(
          post: query.data,
          user: current_user,
          form: form
        ).call

        if result.success?
          success(
            message: result.message,
            data: PostSerializer.render(result.data)
          )
        else
          failure(
            message: result.message,
            errors: result.errors
          )
        end
      end

      def destroy
        query = PostQuery.new(params[:id]).call

        unless query.success?
          return failure(
            message: query.message,
            status: :not_found
          )
        end

        result = Posts::DeleteService.new(
          post: query.data,
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

      def liked
        result = LikedPostsQuery.new(
          user: current_user,
          params: params
        ).call

        success(
          data: PostsSerializer.render(
            result.data
          ),
          meta: result.meta
        )
      end

      private

      def post_params
        params.permit(
          :title,
          :description,
          :location,
          :latitude,
          :longitude,
          :priority,
          :post_type,
          media: [],
          remove_media_ids: []
        )
      end
    end
  end
end