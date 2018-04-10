Rails.application.routes.draw do
  resources :annoucements
  resources :groups do
    member do
      post :join_group
      get :join_group
    end
  end
  get '/user_groups/', to: 'groups#user_groups', as: 'user_groups'
  root 'home#index', as: 'home_index'
  delete '/leave_group/:id', to: 'groups#leave_group', as: 'leave_group'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
