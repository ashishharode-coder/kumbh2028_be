module Posts

  class CreateService

    def initialize(user, form)

      @user = user
      @form = form

    end

    def call

      return failure(@form.errors) unless @form.valid?

      post = @user.posts.create!(

        title: @form.title,
        description: @form.description,
        location: @form.location,
        latitude: @form.latitude,
        longitude: @form.longitude,

        priority: @form.priority,
        post_type: @form.post_type,

        status: :pending

      )

      if @form.media.present?

        post.media.attach(@form.media)

      end

      success(post)

    end

    private

    def success(post)
      ServiceResult.new(
        success: true,
        data: post,
        message: "Post created successfully."
      )
    end

    def failure(errors)
      ServiceResult.new(
        success: false,
        errors: errors,
        message: "Validation failed."
      )
    end

  end

end