SimplyBetter::Application.routes.draw do

  resources :features do
    resources :comments, only: :create
  end
  resources :comments, only: :destroy
  resources :customers, only: [:index, :new, :create] do
    member do
      post :create_application
    end
  end

  resources :applications, only: [:index, :create]

  get 'widget' => "widget#widget"

  get 'features/:feature_id/vote_status' => "votes#status"
  get 'applications/:id' => "applications#administrate", as: "application_administrate"
  get 'applications/:id/feature/new' => "applications#new_feature", as: "application_new_feature"
  post 'applications/:id/feature/create' => "applications#create_feature"
  get 'applications/:id/features/:fid/edit' => "applications#edit_feature", as: "applications_edit_feature"
  patch 'applications/:id/features/:fid' => "applications#update_feature"
  delete 'applications/:id/features/:fid' => "applications#delete_feature", as: "applications_delete_feature"
  get 'applications/:id/administrate_group' => "applications#administrate_group", as: "administrate_group"
  post 'applications/:id/add_request_to_group/:fid' => "applications#add_feature_request_to_group", as: "add_feature_request_to_group"
  delete 'applications/:id/remove_request_from_group/:fid' => "applications#remove_feature_request_from_group", as: "remove_feature_request_from_group"

  get '/comments/create' => "comments#create"
  get '/comments/destroy' => "comments#destroy"
  post '/vote_up' => "votes#up"
  post '/vote_down' => "votes#down"
  get '/login' => "sessions#new"
  post '/sessions/create' => "sessions#create"
  root 'sessions#new'

end
