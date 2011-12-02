class WishlistItem
  include Mongoid::Document
  validates :product_name, :presence => true

  field :product_name, :type => String

	belongs_to :user
end
