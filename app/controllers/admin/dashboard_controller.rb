module Admin
  class DashboardController < ApplicationController
    def index
      @dashboard = Admin::Dashboard::DashboardService.call
    end
  end
end