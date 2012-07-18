BaseApp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    resources :pins, :only => [ :create, :destroy ] 
  end

  get "pages/index"
  match "/about" => "pages#about"
  match "/tools" => "pages#tools"

  match "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  resources :users, :only => :show

  resources :items do
    resources :tags, :only => :create
    resources :comments, :only => :create
    match 'tag_filter' => 'items#tag_filter', :on => :collection
  end
  resources :pins, :only => :update
  resources :streams do
    match 'items' => 'stream_pins#create'
  end
  
  match '/tags/:name' => 'tags#show'

  match '/library' => 'pins#index'
  match '/library_items' => 'pins#library_items'
  match '/public/:user_id/library' => 'users#show', :as => :public_library

  match '/bookmarklet/learned' => 'bookmarklet#learned'

  root :to => "pages#index"
end
