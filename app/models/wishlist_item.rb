class WishlistItem
  include Mongoid::Document
  field :product_name, :type => String

	belongs_to :user
end
