module Authentication
  extend ActiveSupport::Concern

  # included do
  #   before_action :require_authentication
  #   helper_method :authenticated?
  # end

  private

  def resume_session
    token = cookies.signed[:session_token]

    return if token.blank?

    session = Session.active.find_by(token: token)

    return unless session

    Current.session = session
    Current.actor = session.authenticatable

    session.update_column(:last_seen_at, Time.current)
  end

  def current_actor
    Current.actor
  end

  def signed_in?
    Current.actor.present?
  end

  def require_authentication
    return if signed_in?

    redirect_to new_admin_session_path
  end
end
