Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :people, only: [:index, :create, :show]
      resources :films, only: [:index, :create, :show]
      resources :starships, only: [:index, :create, :show]
      resources :vehicles, only: [:index, :create, :show]
      resources :species, only: [:index, :create, :show]
      resources :planets, only: [:index, :create, :show]
    end
  end

  root to: "home#index"
end
