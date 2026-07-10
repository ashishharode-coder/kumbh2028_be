module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :resume_session
  end

  private

  def resume_session
    Current.session = Session.find_by(id: cookies.signed[:session_id])

    Current.actor = Current.session&.authenticatable
  end

  def require_authentication
    redirect_to login_path unless Current.actor
  end
end