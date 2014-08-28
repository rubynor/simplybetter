SimplyBetter::Application.routes.draw do

  resources :landing_page, only: :index

  namespace :widget_api do
    resources :ideas, except: [:new, :edit] do
      resources :comments, only: [:create, :destroy, :index, :show]
      get :find_similar, on: :collection
    end
    resources :votes, only: [] do
      get :cast, on: :collection
      post :cast, on: :collection
    end
    resources :applications, only: [:show] do
      get :client_js, on: :collection
    end
    resources :notifications, only: [:index,:update] do
      get :count, on: :collection
    end
    resource :user, only: [:show, :update]
    resource :email_settings, only: [:show, :update]
  end

  resources :customers, only: [:index, :new, :create, :edit, :update] do
    member do
      get :edit_unsafe
      put :update_unsafe
      patch :update_unsafe
    end
  end

  resources :applications, except: [:destroy] do
    get :administrate_group, on: :member
    get :preview, on: :member
    resources :ideas, only: [:index, :update, :destroy]
  end

  resources :comments, only: [:update]

  resources :email_settings, param: :unsubscribe_token, only: [] do
    get :unsubscribe, on: :member
  end

  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'widget' => "widget#widget"

  get '/login' => "sessions#new"
  post '/sessions/create' => "sessions#create"
  root 'sessions#new'
  delete '/sessions/destroy' => "sessions#destroy", as: "sign_out"

end
