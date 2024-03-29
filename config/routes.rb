Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users, controllers: {invitations: 'users/devise_invitations'}
  resources :organizations do
    resources :push_notifications
    resources :users, only: [:index, :show, :update, :edit, :destroy] do
      resource :comments
      collection do
        resources :invitations, only: [:new, :create], controller: 'users/invitations'
      end
      member do
        patch :invite
      end
    end
    resources :groups do
      resources :departments
      resources :makes
    end
    resources :basic_forms
    resources :customers
    resources :cars do 
      resource :like, module: :cars
      collection do 
        get 'models/' => 'cars#models'
        get 'unknown' => 'cars#unknown'
      end
    end
    resources :locations
    resources :pages
    post '/cars/scrape/' => 'cars#scrape'
  end

 #this is make and modals which are not per org but global and the same across all organizations
  resources :makes do 
    resources :models 
  end
  get 'models/' => 'models#index'

  namespace :api do
    namespace :v1 do
      post 'users/sign_in', to: 'sessions#create'
      delete 'users/sign_out', to: 'sessions#destroy'
      get 'users/auth_test', to: 'sessions#auth_test'
      post 'users/sign_up', to: 'users#create'
      post 'users/forgot_password', to: 'users#forgot_password'
      post '/basic_forms/create/', to: 'basic_forms#create'
      post '/device_tokens/set', to: 'device_tokens#set'
      post '/locations/create/', to: 'locations#create'
      post '/page_impressions/create/', to: 'page_impressions#create'
      resources :users
    end
  end

  get 'icon_select', to: 'departments#icon_select', as: 'modal_icon_select'
end
