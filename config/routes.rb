Rails.application.routes.draw do
  root "coubs#index"
  resources :coubs, only: [:create]

  get "/auth/:provider/callback" => "sessions#create"
  get "logout" => "sessions#destroy"

end
