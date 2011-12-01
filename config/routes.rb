Toupoutou::Application.routes.draw do
  root :to => "home#index"

	resource "friends"

  get "dashboard/" => "dashboard#index"

  devise_for :users
end
