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

  resources :items do
    resources :tags, :only => :create
    match 'tag_filter' => 'items#tag_filter', :on => :collection
  end
  resources :pins, :only => :update
  
  match '/tags/:name' => 'tags#show'

  match '/library' => 'pins#index'
  match '/library_items' => 'pins#library_items'
  match '/public/:user_id/library' => 'pins#public_index', :as => :public_library

  root :to => "items#index"
end
