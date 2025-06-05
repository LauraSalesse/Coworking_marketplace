Rails.application.routes.draw do
  devise_for :users
  root to: "desks#index"

  # Health‐check endpoint:
  get "up" => "rails/health#show", as: :rails_health_check

  # “My next work spots” page:
  get '/renter_bookings', to: 'bookings#renter_bookings', as: :renter_bookings

  # Alias for desks#index:
  get '/offers', to: 'desks#index', as: 'offers'

  # Desks (with a “confirm” member action):
  resources :desks, only: %i[index new create show edit update destroy] do
    member do
      get :confirm
    end
  end

  # “My desks” (the owner’s view):
  get 'mydesks', to: 'desks#mydesks', as: :mydesks

  # Booking creation (POST /bookings → bookings#create):
  resources :bookings, only: [:create, :destroy]
end
