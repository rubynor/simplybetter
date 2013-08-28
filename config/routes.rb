Howhard::Application.routes.draw do

  resources :features do
    resources :comments, only: :create
  end
  resources :comments, only: :destroy
  resources :customers, only: [:index, :new, :create] do
    member do
      post :create_application
    end
  end

  get 'applications/:id' => "applications#administrate"
  get 'applications/:id/feature/new' => "applications#new_feature", as: "application_new_feature"
  post 'applications/:id/feature/create' => "applications#create_feature"
  get 'applications/:id/administrate_group' => "applications#administrate_group", as: "administrate_group"

  get '/comments/create' => "comments#create"
  get '/comments/destroy' => "comments#destroy"
  get '/vote' => "votes#cast"
  get '/login' => "sessions#new"
  post '/sessions/create' => "sessions#create"
  root 'features#index'

end
