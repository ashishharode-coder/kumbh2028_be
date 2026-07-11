Rails.application.routes.draw do
  resources :passwords, param: :token
  namespace :admin do
    root "dashboard#index"
    resources :posts
    resources :users
    resource :session,
             only: %i[new create destroy]

  end

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post :send_otp
        post :verify_otp
      end

      get "me", to: "users#me"
      delete "logout", to: "users#logout"
    end
  end


  get "up" => "rails/health#show", as: :rails_health_check
end
