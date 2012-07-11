BaseApp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    resources :pins
  end

  get "pages/index"

  match "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  resources :items do
    resources :tags, :only => :create
    match 'tag_filter' => 'items#tag_filter', :on => :collection
  end
  match '/tags/:name' => 'tags#show'

  match '/library' => 'library#index'

  root :to => "items#index"
end
