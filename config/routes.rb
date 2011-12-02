require "resque/server"

Toupoutou::Application.routes.draw do
  root :to => "home#index"

	resources "friends"
	resources "wishlist_items", :only => [:create]

  mount Resque::Server.new, :at => "/resque"

  get "dashboard/" => "dashboard#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    root :to => 'home#index'
  end
end
