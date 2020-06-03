Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :exercises do
    resources :measurements
  end

  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
