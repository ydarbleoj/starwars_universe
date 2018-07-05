Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      resources :people, only: [:index, :show]
      resources :films, only: [:index, :show]
      resources :starships, only: [:index, :show]
      resources :vehicles, only: [:index, :show]
      resources :species, only: [:index, :show]
      resources :planets, only: [:index, :show]
    end
  end
end
