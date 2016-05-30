Rails.application.routes.draw do
  

  resources :categories

  # singular resource
  resource :session
  # when we get signup than go to user controller
  get "signup" => "users#new"
  resources :users

  root "events#index"
# nested resources using ruby block
# inside the events we have ruby block with registrations
# nested likes resources inside events
  resources :events do
    resources :registrations
    resources :likes
  end
end
