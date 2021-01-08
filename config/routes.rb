Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/transactions/:apn_code', to: 'transactions#show'
    end
  end

  root to: 'static_pages#landing'
  get 'static_pages/landing'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end