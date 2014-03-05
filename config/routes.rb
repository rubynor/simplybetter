SimplyBetter::Application.routes.draw do

  namespace :widget_api do
    resources :ideas do
      resources :comments, only: [:create, :destroy, :index, :show]
    end
    resources :votes, only: [] do
      get :cast, on: :collection
      post :cast, on: :collection
    end
    resources :applications, only: [:show] do
      get :client_js, on: :collection
      resources :ideas do
        get :find_similar, on: :collection
      end
    end
    resources :notifications, only: [:index,:update]
  end

  resources :customers, only: [:index, :new, :create] do
    member do
      post :create_application
    end
  end

  resources :applications, except: [:destroy] do
    get :administrate_group, on: :member
    resources :ideas do
      post :add_to_group, on: :member
      delete :remove_from_group, on: :member
    end
  end

  get 'widget' => "widget#widget"

  get '/login' => "sessions#new"
  post '/sessions/create' => "sessions#create"
  root 'sessions#new'
  delete '/sessions/destroy' => "sessions#destroy", as: "sign_out"

end
