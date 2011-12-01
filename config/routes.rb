require "resque/server"

Toupoutou::Application.routes.draw do
  root :to => "home#index"

  mount Resque::Server.new, :at => "/resque"

  resource "friends"

  get "dashboard/" => "dashboard#index"


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    root :to => 'home#index'
  end
end
