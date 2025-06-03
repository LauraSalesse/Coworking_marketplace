Rails.application.routes.draw do
  devise_for :users
  root to: "desks#index"            # “Landing” as the desks index

  resources :desks, only: [:index, :new, :create, :show] do
    # if you eventually want nested bookings:
    resources :bookings, only: [:new, :create]
  end

  # (Optional) standalone route for bookings#index or bookings#show if needed
  resources :bookings, only: [:index, :show]
end
