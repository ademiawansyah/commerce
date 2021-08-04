# frozen_string_literal: true

class CartsController < ApplicationController
  # GET users/user_id/carts
  def index
    # TODO: REPLACE User.first.id with params, for testing purpose only
    @cart = Cart.includes(cart_items: [product_variant: :product])
                .find_by(user_id: User.first.id)

    @grouping_items = @cart.cart_items.where(checkout_at: nil)
                           .group_by { |ci| ci.product_variant.product.store }
  end
end
