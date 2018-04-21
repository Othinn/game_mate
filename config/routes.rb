Rails.application.routes.draw do

  resources :annoucements do
    resources :comments, only: [:destroy, :create, :new]
  end
  resources :groups do
    member do
      get :join_group
      delete :leave_group
    end
  end
  root 'home#index', as: 'home_index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
