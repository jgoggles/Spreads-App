Spreads::Application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "games", to: "games#index"
      get "picks", to: "picks#index"
      get "standings", to: "standings#index"
    end
  end

  get "scoreboard/live"

  devise_for :users, :controllers => { :registrations => "users/registrations" }

  resources :badges

  get "/dashboard"=> 'dashboard#index'

  resources :pools do
    resources :pick_sets do
      collection do
        post :build
        get :user
      end
    end
    resources :topics
    get '/standings' => 'standings#index'
    get '/standings/:week_id' => 'standings#show', :as => "standings_for_week"
    get '/players' => 'pools/players#index', :as => "players"
    match 'update_pool_users' => 'pools/players#update_pool_users', :as => "update_players", via: [:get, :post]
    member do
      get 'achievements', :as => 'achievements'
      get 'rules', :as => 'rules'
    end
    get '/live' => 'scoreboard#live'
  end

  resources :games do
    collection do
      get :load
    end
  end

  resources :weeks, :pool_types, :pool_users, :messages
  root :to => 'dashboard#index'
end
