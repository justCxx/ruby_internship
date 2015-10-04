Rails.application.routes.draw do
  root "welcome#index"

  devise_for :users, controllers: { registrations: "registrations" }

  devise_scope :user do
    get "users/sign_up/admin", to: "registrations#new_admin", as: :sign_up_admin
    get "users/sign_up/guest", to: "registrations#new_guest", as: :sign_up_guest
    get "users/sign_up/shop_owner", to: "registrations#new_shop_owner",
                                    as: :sign_up_shop_owner
  end

  resources :products do
    member do
      get "buy"
      put "set_pro"
    end
  end
end
