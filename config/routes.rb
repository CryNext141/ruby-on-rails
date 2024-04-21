Rails.application.routes.draw do
  devise_for :users
  root 'hi_world#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html



  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'movies/search', to: 'movies#search', as: 'search_movies'

  # Defines the root path route ("/")
  # root "posts#index"

  resources :users, only: [] do
    get 'userpage', on: :member
  end


  resources :movies do
    collection do
      get :omdb_search
      post :omdb_import
    end
    member do
      post 'add_to_favorites'
      delete 'remove_from_favorites'
    end
    resources :comments
  end

end
