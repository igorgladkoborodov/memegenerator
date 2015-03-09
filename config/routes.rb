Rails.application.routes.draw do
  root "sessions#index"
  get "/auth/:provider/callback" => "sessions#create"
  get "logout" => "sessions#destroy"
end
