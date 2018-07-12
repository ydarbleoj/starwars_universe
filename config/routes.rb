Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :people, only: [:index, :create, :show], param: :person_id
      resources :films, only: [:index, :create, :show], param: :film_id
      resources :starships, only: [:index, :create, :show], param: :starship_id
      resources :vehicles, only: [:index, :create, :show], param: :vehicle_id
      resources :species, only: [:index, :create, :show], param: :species_id
      resources :planets, only: [:index, :create, :show], param: :planet_id
    end
  end

  root to: "home#index"
end
