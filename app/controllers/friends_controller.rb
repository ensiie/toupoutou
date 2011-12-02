class FriendsController < ApplicationController
  def import
    @facebook_friends = current_user.facebook_friends
  end

  def validate_import
    current_user.facebook_friends.each do |fbf|
      if params[:imports].map{|hsh| hsh.keys}.first.include? fbf.id.to_s
        current_user.friends << fbf
      else
        current_user.friends.delete fbf
      end
    end
    redirect_to :action => :import
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
