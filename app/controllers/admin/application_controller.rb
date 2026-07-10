module Admin
  class ApplicationController < Administrate::ApplicationController
    include Authentication

    before_action :require_authentication

    layout "admin"
  end
end