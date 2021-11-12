Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      resources :users
      resources :categories
      resources :products
      resources :orders
      resources :user_profiles
      resources :order_details
      post "/activeUser",   to: "users#active"
      post "/changeType",   to: "orders#changeType"
      post "/checkProduct", to: "orders#checkProduct"
      post "/login",        to: "sessions#create"
      get "/login",         to: "sessions#token_authenticate"
    end
  end
end

