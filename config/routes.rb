Rails.application.routes.draw do
  resources :passwords, param: :token
  namespace :admin do
    root "dashboard#index"
    resources :posts
    resources :users do
      member do
        patch :block
        patch :unblock
        delete :logout_everywhere
      end
      delete :logout_session,
           on: :member
    end
    resource :session,
             only: %i[new create destroy]

  end

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post :send_otp
        post :resend_otp
        post :verify_otp
      end

      resources :posts

      get "my/posts",
        to: "posts#my_posts"

      get "me", to: "users#me"
      delete "logout", to: "users#logout"
    end
  end


  get "up" => "rails/health#show", as: :rails_health_check
end
