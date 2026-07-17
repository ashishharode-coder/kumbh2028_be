module Posts
  class UpdateService
    def initialize(post:, user:, form:)
      @post = post
      @user = user
      @form = form
    end

    def call
      return unauthorized unless owner?
      return validation_failure unless form.valid?

      ActiveRecord::Base.transaction do
        update_post
        attach_media
        remove_media
      end

      success
    rescue ActiveRecord::RecordInvalid
      failure(post.errors)
    end

    private

    attr_reader :post, :user, :form

    def owner?
      post.user_id == user.id
    end

    def update_post
      post.assign_attributes(form.attributes_hash)
      post.save!
    end

    def attach_media
      return if form.media.blank?

      post.media.attach(form.media)
    end

    def remove_media
      return if form.remove_media_ids.blank?

      post.media_attachments
          .where(id: form.remove_media_ids)
          .find_each(&:purge)
    end

    def success
      ServiceResult.new(
        success: true,
        message: "Post updated successfully.",
        data: post
      )
    end

    def validation_failure
      ServiceResult.new(
        success: false,
        message: "Validation failed.",
        errors: form.errors
      )
    end

    def unauthorized
      ServiceResult.new(
        success: false,
        message: "You are not authorized to update this post."
      )
    end

    def failure(errors)
      ServiceResult.new(
        success: false,
        message: "Unable to update post.",
        errors: errors
      )
    end
  end
end