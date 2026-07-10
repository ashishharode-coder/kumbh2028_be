module AdminAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :resume_admin_session

    helper_method :current_super_admin
  end

  private

  def resume_admin_session
    SessionManager.resume(cookies: cookies)
  end

  def current_super_admin
    Current.super_admin
  end

  def authenticate_super_admin!
    return if current_super_admin.present?

    redirect_to new_admin_session_path
  end
end