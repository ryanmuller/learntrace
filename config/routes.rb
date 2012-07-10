BaseApp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    resources :pins
  end

  get "pages/index"

  match "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  resources :items, :except => [ :index ] do
    resources :tags, :only => :create
  end
  match '/tags/:name' => 'tags#show'

  match '/items' => 'library#index'

  root :to => "items#index"
end
