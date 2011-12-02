class DashboardController < ApplicationController
  def index
		@item = WishlistItem.new
		@items = current_user.wishlistItems
    @birthdays = current_user.friends.where(:birthday.lt => Date.today+30).where(:birthday.gt => Date.today)
  end
end
