Rails.application.routes.draw do
  resources :users
  root "users#index"
  get 'credit_limit_formula', to: 'users#credit_limit_formula'
  get 'result', to: 'users#result'

  namespace :api do 
    namespace :v2 do
      resources :credits
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
