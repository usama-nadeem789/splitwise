Rails.application.routes.draw do
  devise_for :users
  
  resources :friendships, only: [:index, :new, :create, :destroy]

  resources :expense_groups do
    member do
      get 'add_friends'
      post 'create_membership'
      delete 'remove_friend'
    end
    resources :expenses, only: [:index, :new, :create, :destroy]
  end

  root 'expense_groups#index'
end
