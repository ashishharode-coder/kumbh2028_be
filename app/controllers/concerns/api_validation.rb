module ApiValidation
  extend ActiveSupport::Concern

  private

  def validate_form(form)
    return true if form.valid?

    failure(
      message: "Validation failed",
      errors: form.errors.to_hash
    )

    false
  end
end