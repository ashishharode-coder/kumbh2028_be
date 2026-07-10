module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :resume_session
    helper_method :current_actor, :signed_in?
  end

  private

  def resume_session
    SessionManager.resume(cookies: cookies)
  end

  def current_actor
    Current.authenticatable
  end

  def signed_in?
    Current.authenticatable.present?
  end

  def require_authentication
    redirect_to new_admin_session_path unless signed_in?
  end
end