Rails.application.routes.draw do
  # when we get signup than go to user controller
  get "signup" => "users#new"
  resources :users

  root "events#index"
# nested resources using ruby block
# inside the events we have ruby block with registrations
  resources :events do
    resources :registrations
  end
end
