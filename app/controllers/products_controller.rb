# frozen_string_literal: true

class ProductsController < ApplicationController

  # GET /carts
  def index
    @products = Product.includes(%i[store])
                       .search(params)
                       .page(params[:page] || 1)
                       .per(5)

    fresh_when(@products)
  end
end
