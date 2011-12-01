Toupoutou::Application.routes.draw do
  root :to => "home#index"
  get "dashboard/index"
  devise_for :users
end
