class FriendsController < ApplicationController
	def index
		@friends = current_user.friends
	end

	def destroy
		@friend = User.find(params[:id])
		@friend.destroy
		redirect_to friends_path
	end
end
