class DashboardController < ApplicationController
  def index
    @brithdays = current_user.friends.where(:birthday.lt => DateTime.now+30.day).where(:birthday.gt => DateTime.now)
  end
end
