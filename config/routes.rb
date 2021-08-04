Rails.application.routes.draw do
  resources :users do
    resources :carts, only: [:index]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products
end
