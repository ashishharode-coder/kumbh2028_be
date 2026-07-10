module Admin
  class DashboardController < ApplicationController
    def index
      @stats = {
        users: User.count,
        posts: Post.count,
        vendors: 0,
        bookings: 0
      }
    end
  end
end