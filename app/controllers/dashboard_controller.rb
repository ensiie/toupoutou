class DashboardController < ApplicationController
 
  before_filter :authenticate_user!

  def index
		@item = WishlistItem.new
		@items = current_user.wishlistItems
		
		@birthday = []
		@birthdays = []
		@birth = []
		User.all.each do |u|
		  if !(u.birthday.nil?) and (u.birthday.to_s.last(5).split("-").join <= (Date.today+20).to_s.last(5).split("-").join) and (u.birthday.to_s.last(5).split("-").join >= (Date.today).to_s.last(5).split("-").join)
		    @birthdays << u.birthday
		    @birth << u
      else
      
      end
    end
  end
end


  
  # 
  
  #if @birthday.last and ((@birthday.last-@birthday.last.year.years) <= ((Date.today)+10)-Date.today.year.years)
