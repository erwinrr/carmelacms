Rails.application.routes.draw do

  root to: "pages#home"
  devise_for :users, controllers: {invitations: 'users/devise_invitations'}

  resources :organizations do
    resources :users, only: [:index, :show, :update, :edit, :destroy] do
      collection do
        resources :invitations, only: [:new, :create], controller: 'users/invitations'
      end
      member do
        patch :invite
      end
    end
    resources :groups do
      resources :departments
    end
    resources :basic_forms
    resources :customers
    resources :cars
    post '/cars/scrape/' => 'cars#scrape'
  end

  namespace :api do
    namespace :v1 do
      post 'users/sign_in', to: 'sessions#create'
      delete 'users/sign_out', to: 'sessions#destroy'
      get 'users/auth_test', to: 'sessions#auth_test'
      post 'users/sign_up', to: 'users#create'
      post 'users/forgot_password', to: 'users#forgot_password'
      post '/basic_forms/create/', to: 'basic_forms#create'
      resources :users
    end
  end

  get 'icon_select', to: 'departments#icon_select', as: 'modal_icon_select'
end
