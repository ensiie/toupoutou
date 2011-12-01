Toupoutou::Application.routes.draw do
  root :to => "home#index"

	resource "friends"

  devise_for :users
end
