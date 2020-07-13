Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  concern :api_base do
    resources :users do
      resources :measurements
    end
    resources :exercises
    post 'login', to: 'authentication#authenticate'
    post 'signup', to: 'users#create'
  end

  namespace :v1 do
    concerns :api_base
  end

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Raddocs::App => "/api_docs"
  mount GrapeSwaggerRails::Engine => '/swagger'
end



