require "resque/server"

Toupoutou::Application.routes.draw do
  root :to => "home#index"
  
	match "dashboard" => "dashboard#index"
  match "friends" => "friends#import"
  
  mount Resque::Server.new, :at => "/resque"

	resources "friends"
	resources "wishlist_items", :only => [:create]

  get "dashboard/" => "dashboard#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    root :to => 'home#index'
  end
end
