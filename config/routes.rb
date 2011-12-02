require "resque/server"

Toupoutou::Application.routes.draw do
  root :to => "home#index"
  
	match "dashboard" => "dashboard#index"
  match "friends" => "friends#import"
  
  mount Resque::Server.new, :at => "/resque"

  resources "wishlist_items", :only => [:create] do
    get :autocomplete_wishlistItem_product_name, :on => :collection
  end

  resources :friends do
    get :import, :action => 'import', :on => :collection
    post :import, :action => 'validate_import', :on => :collection, :as => :vimports
  end

  get "dashboard/" => "dashboard#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    root :to => 'dashboard#index'
  end
end
