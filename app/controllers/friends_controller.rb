class FriendsController < ApplicationController
  def import
    @facebook_friends = current_user.facebook_friends
  end

  def validate_import
    @friends = params[current_user][:friends]
    current_user.friends += @friends
  end
end
