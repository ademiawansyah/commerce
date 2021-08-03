class ProductsController < ApplicationController
  # before_action :set_cart, only: [:show, :update, :destroy]

  # GET /carts
  def index
    @products = Product.all
  end
end
