class FriendsController < ApplicationController
  def import
    @facebook_friends = current_user.facebook_friends
  end

  def validate_import
    @friends = params[current_user][:friends]
    current_user.friends += @friends
  end

	def index
		@friends = current_user.friends
	end

	def destroy
		@friend = User.find(params[:id])
		@friend.destroy
		redirect_to friends_path
	end
end
