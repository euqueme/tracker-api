Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    resources :measurements
  end
  resources :exercises
  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  mount Raddocs::App => "/api_docs"
end



