class Music
  include Mongoid::Document

  field :facebook_id, :type => Integer
  field :name

  has_and_belongs_to_many :users
end
