BaseApp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "pages/index"

  match "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  resources :items do
    resources :tags, :only => :create
  end
  match '/tags/:name' => 'tags#show'

  root :to => "pages#index"
end
