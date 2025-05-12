Rails.application.routes.draw do
  get "pages/success"
  devise_for :users

  resources :events

  root "events#index"

  resources :events do
    member do
      post "register", to: "reservations#create"
      delete "cancel", to: "reservations#destroy"
    end
  end

  resources :reservations, only: [ :index ] # For listing a user's registered events


  resources :events do
    resources :payments, only: [ :create ]
  end
  get "/success", to: "pages#success"
  get "/cancel", to: "pages#cancel", as: "cancel"
end
