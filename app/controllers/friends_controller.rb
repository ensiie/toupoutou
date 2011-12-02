class FriendsController < ApplicationController

  before_filter :authenticate_user!

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
    redirect_to :action => :index
  end

	def index
		@user = current_user
		@friends = current_user.friends
	end

	def destroy
		@friend = User.find(params[:id])
		current_user.friends.delete @friend
		redirect_to friends_path
	end

	def show
		@friend = User.find(params[:id])
	end
end
