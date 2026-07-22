module Comments
  class CreateService
    def initialize(post:, user:, form:)
      @post = post
      @user = user
      @form = form
    end

    def call
      return validation_failure unless form.valid?

      comment = post.comments.new(
        form.attributes_hash.merge(user: user)
      )

      if comment.save
        success(comment)
      else
        failure(comment.errors)
      end
    end

    private

    attr_reader :post, :user, :form

    def success(comment)
      ServiceResult.new(
        success: true,
        message: "Comment created successfully.",
        data: comment
      )
    end

    def validation_failure
      ServiceResult.new(
        success: false,
        message: "Validation failed.",
        errors: form.errors
      )
    end

    def failure(errors)
      ServiceResult.new(
        success: false,
        message: "Unable to create comment.",
        errors: errors
      )
    end
  end
end