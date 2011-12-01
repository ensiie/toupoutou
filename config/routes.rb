Toupoutou::Application.routes.draw do
  root :to => "home#index"

	namespace :friends do
		root :to => "friends#index"
	end

  devise_for :users
end
