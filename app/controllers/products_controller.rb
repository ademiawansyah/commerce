# frozen_string_literal: true

class ProductsController < ApplicationController
  # before_action :set_cart, only: [:show, :update, :destroy]

  # GET /carts
  def index
    @products = Product.includes(%i[store])
                       .search(params)
                       .page(params[:page] || 1)
                       .per(5)

    fresh_when(@products)
  end
end
