# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users do
    resources :carts, only: [:index]
    resources :cart_items, only: %i[create update destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products
end
