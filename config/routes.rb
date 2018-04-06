Rails.application.routes.draw do
  resources :annoucements
  resources :groups do
    member do
      get :user_groups
      post :join_group
      get :join_group
      delete :leave_group

    end
  end
  root 'home#index', as: 'home_index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
