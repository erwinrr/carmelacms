Rails.application.routes.draw do

  root to: "pages#home"
  devise_for :users

  resources :organizations do
    resources :users, only: [:index, :show, :update, :edit, :destroy]
    resources :groups do
      resources :departments
    end
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
      resources :users
    end
  end

  get 'icon_select', to: 'departments#icon_select', as: 'modal_icon_select'
end