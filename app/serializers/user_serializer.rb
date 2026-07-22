class UserSerializer
  def self.render(user)
    return if user.blank?

    {
      id: user.id,
      name: user.name,
      mobile_number: user.phone,
      # avatar_url: avatar_url(user)
    }
  end

  class << self
    private

    def avatar_url(user)
      return unless user.avatar.attached?

      Rails.application.routes.url_helpers.rails_blob_url(
        user.avatar,
        only_path: true
      )
    end
  end
end