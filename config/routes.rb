Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/get_apns/', to: 'transactions#get_all_apns'
      get '/transactions/:apn_code', to: 'transactions#show'
      get '/transactions/:apn_code/dates/', to: 'transactions#get_dates'
    end
  end

  root to: 'static_pages#landing'
  get 'static_pages/landing'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end