class DashboardController < ApplicationController
  def index
		@items = current_user.wishlistItems
  end
end
