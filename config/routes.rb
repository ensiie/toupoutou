Toupoutou::Application.routes.draw do
  root :to => "home#index"
  match "dashboard" => "dashboard#index"
  match "friends" => "friends#import"
  
  devise_for :users
end
