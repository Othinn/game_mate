Rails.application.routes.draw do
  resources :annoucements
  resources :groups
  root 'home#index', as: 'home_index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
