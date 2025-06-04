Rails.application.routes.draw do
  devise_for :users
  root to: "desks#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/offers', to: 'desks#index', as: 'offers'

  # Defines the root path route ("/")
  # root "posts#index"
<<<<<<< HEAD
  resources :desks, only: %i[index new create show] do
    member do
      get :confirm
    end
  end
=======
  resources :desks, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # add the routes to mydesks Max
  get 'mydesks', to: 'desks#mydesks'
>>>>>>> master
end
