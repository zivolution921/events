Rails.application.routes.draw do
  
  resources :categories
  # singular resource
  resource :session
  # when we get signup than go to user controller
  get "signup" => "users#new"

  # creating all Resful routes for users resource
  resources :users

  match 'auth/:provider/callback', to: 'sessions#facebook', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  root "events#index"
# nested child resources registrations inside parent events using ruby block
# nested registration resources inside events
  resources :events do
    resources :registrations
    resources :likes
  end
end
