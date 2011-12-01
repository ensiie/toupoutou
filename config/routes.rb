Toupoutou::Application.routes.draw do
  root :to => "home#index"

	resources "friends"

  get "dashboard/" => "dashboard#index"

  devise_for :users
end
