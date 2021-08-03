# frozen_string_literal: true

class ProductsController < ApplicationController
  # before_action :set_cart, only: [:show, :update, :destroy]

  # GET /carts
  def index
    @products = Product.page(params[:page] || 1)
                       .per(5)
  end
end
