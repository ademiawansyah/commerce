# frozen_string_literal: true

class CartsController < ApplicationController

  # GET users/user_id/carts
  def index
    # TODO: REPLACE User.first.id with params, for testing purpose only
    @cart = Cart.includes(cart_items: [product_variant: :product])
                .where(user_id: User.first.id)
                .active

    @grouping_items = @cart.cart_items.group_by { |ci| ci.product_variant.product.store }
  end
end
