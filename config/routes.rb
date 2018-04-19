Rails.application.routes.draw do

  resources :annoucements do
    resources :comments
  end

  resources :groups do
    member do
      get :leave_group
      get :join_group
    end
  end
  get '/user_groups/', to: 'groups#user_groups', as: 'user_groups'
  root 'home#index', as: 'home_index'

  delete '/leave_group/:id', to: 'groups#leave_group', as: 'leave_group'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
