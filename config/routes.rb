Toupoutou::Application.routes.draw do
  root :to => "home#index"
  match "dashboard" => "dashboard#index"
  match "friends" => "friends#import"
  

	resource "friends"

  devise_for :users
end
