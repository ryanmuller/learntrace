BaseApp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } 
  devise_scope :users do
    resources :pins, :only => [ :create, :destroy ] 
  end

  get "pages/index"
  match "/about" => "pages#about"
  match "/tools" => "pages#tools"

  match "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  match '/users/:id' => 'users#show', :as => :user, :constraints => { :id => /\d+/ }
  match '/users/:username' => 'users#show', :as => :username, :constraints => { :username => /[a-zA-Z0-9_\-\.]+/ }
 

  resources :items do
    resources :tags, :only => :create
    resources :comments, :only => :create
    match 'tag_filter' => 'items#tag_filter', :on => :collection
  end
  resources :pins, :only => :update
  resources :taggings, :only => :destroy
  resources :streams do
    resources :stream_pins, :only => [:create, :destroy, :update]
    resources :forks, :only => [:create, :destroy]
    resources :timeline, :only => :index
  end

  resources :my_streams, :only => :show
  
  match '/tags/:name' => 'tags#show', :as => "tag_name"

  match '/library' => 'pins#index'
  match '/library_items' => 'pins#library_items'
  match '/public/:user_id/library' => 'users#show', :as => :public_library

  match '/bookmarklet/learned' => 'bookmarklet#learned'

  root :to => "streams#index"
end
