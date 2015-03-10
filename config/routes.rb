Rails.application.routes.draw do
  root "coubs#index"
  resources :coubs, only: [:create]

  get "/auth/:provider/callback" => "sessions#create"
  delete "logout" => "sessions#destroy"

end
