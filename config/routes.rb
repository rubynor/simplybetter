SimplyBetter::Application.routes.draw do

  namespace :widget_api do
    resources :features do
      resources :comments, only: :create
    end
    resources :votes, only: [] do
      get :status, on: :collection
      post :up, on: :collection
      post :down, on: :collection
    end
  end

  resources :comments, only: :destroy
  resources :customers, only: [:index, :new, :create] do
    member do
      post :create_application
    end
  end

  resources :applications, only: [:index, :create, :show] do
    get :administrate_group, on: :member
    resources :features, except: [:show, :index] do
      post :add_to_group, on: :member
      delete :remove_from_group, on: :member
    end
  end

  get 'widget' => "widget#widget"


  get '/comments/create' => "comments#create"
  get '/comments/destroy' => "comments#destroy"
  get '/login' => "sessions#new"
  post '/sessions/create' => "sessions#create"
  root 'sessions#new'
  delete '/sessions/destroy' => "sessions#destroy", as: "sign_out"

end
