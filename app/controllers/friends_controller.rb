class FriendsController < ApplicationController
	def index
		@friends = Array.new
		user = current_user
		user.friends.each do |f|
			if user.id == f.id then
				@friends.push user
			end
		end
	end
end
