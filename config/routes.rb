Rails.application.routes.draw do
  devise_for :users
  get 'homes/top'
  root :to => "homes#top"
  get 'home/about' => 'homes#about',as: 'about'
  resources :books
  resources :users
end
