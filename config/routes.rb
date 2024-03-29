SimplyBetter::Application.routes.draw do

  get 'ping' => 'application#ping'

  resources :landing_page, only: :index do
    post :contact_us, on: :collection
  end

  namespace :widget_api do
    resources :ideas, except: [:new, :edit] do
      resources :comments, only: [:create, :index, :update], format: :json
      get :find_similar, on: :collection
    end
    resources :votes, only: [] do
      get :cast, on: :collection
      post :cast, on: :collection
    end
    resources :applications, only: [], param: :token do
      get :client_js, on: :collection
      get :is_admin, on: :member
    end
    resources :notifications, only: [:index, :update] do
      get :count, on: :collection
    end
    resources :faqs
    resource :user, only: [:show, :update]
    resource :email_settings, only: [:show, :update]
    resources :support_messages, only: [:create]
  end

  resources :customers, only: [:index, :new, :create, :edit, :update] do
    member do
      get :edit_unsafe
      put :update_unsafe
      patch :update_unsafe
    end
  end

  resources :applications, except: [:destroy, :edit] do
    get :preview, on: :member
    get :show_ideas, on: :member
    get :installation_instructions, on: :member
    get :customization, on: :member
    resources :collaborators, only: [:index, :create, :destroy]
    resources :ideas, only: [:index, :update, :destroy]
    resources :faqs
  end

  resources :email_settings, param: :unsubscribe_token, only: [] do
    get :unsubscribe, on: :member
  end

  resources :password_resets, only: [:new, :create, :edit, :update] do
    get :check_email, on: :collection
  end

  get 'widget' => 'widget#widget'

  resource :sessions, only: [], path: '', as: '' do
    get :login, action: :new
    get :popup_login, action: :popup_new
    get :popup_close
    post :create, path: 'sessions/create'
    post :popup_create, path: 'sessions/popup_create'
    delete :destroy, path: 'sessions/destroy', as: 'sign_out'
  end

  resource :reports, only: [] do
    get :overview
  end

  root 'landing_page#index'
end
