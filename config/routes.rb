Rails.application.routes.draw do

  resources :companies, only: [:new, :create]
  root to: 'jobs#premium'
  resources :jobs do
  post "comments", to: "comments#create"
  end
  delete "comments/:id", to: "comments#destroy", as: :comment
  get 'hello/world'

  get  "/companies/login", to: "login#new"
  post "/companies/login", to: "login#create"
  delete "/companies/login", to: "login#destroy"

end
