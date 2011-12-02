class WishlistItemsController < ApplicationController
  autocomplete :wishlistItem, :product_name, :full => true

	def create
		current_user.wishlistItems.create(params[:wishlist_item])
		redirect_to dashboard_path
	end
end
