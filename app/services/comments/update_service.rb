module Comments
  class UpdateService
    def initialize(comment:, user:, form:)
      @comment = comment
      @user = user
      @form = form
    end

    def call
      return unauthorized unless owner?
      return validation_failure unless form.valid?

      if comment.update(form.attributes_hash)
        success(comment)
      else
        failure(comment.errors)
      end
    end

    private

    attr_reader :comment, :user, :form

    def owner?
      comment.user_id == user.id
    end

    def success(comment)
      ServiceResult.new(
        success: true,
        message: "Comment updated successfully.",
        data: comment
      )
    end

    def unauthorized
      ServiceResult.new(
        success: false,
        message: "You are not authorized to update this comment."
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
        message: "Unable to update comment.",
        errors: errors
      )
    end
  end
end