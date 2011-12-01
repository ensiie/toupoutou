Toupoutou::Application.routes.draw do
  root :to => "home#index"

	get "friends" => "friends#index"

  get "dashboard" => "dashboard#index"
  
	devise_for :users
end
