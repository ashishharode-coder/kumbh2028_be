module Admin
  class PostsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #

    def create
      @post = Post.new(resource_params)

      if @post.save

        if params[:post][:media].present?
          @post.media.attach(params[:post][:media])
        end

        redirect_to admin_post_path(@post),
                    notice: "Post created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end
    
    def update
      if requested_resource.update(resource_params)

        if params[:post][:media].present?
          requested_resource.media.attach(params[:post][:media])
        end

        redirect_to admin_post_path(requested_resource),
                    notice: "Post updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes(action_name)).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    def resource_params
      params.require(:post).permit(
        :title,
        :description,
        :location,
        :post_type,
        :priority,
        :status,
        :verified,
        :published_at,
        :latitude,
        :longitude
      )
    end

    # See https://administrate-demo.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
