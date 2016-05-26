Rails.application.routes.draw do
  resources :users

  root "events#index"
# nested resources using ruby block
# inside the events we have ruby block with registrations
  resources :events do
    resources :registrations
  end
end
