# frozen_string_literal: true

class CartItemsController < ApplicationController
  def create
    officer = CartItemOfficer.new(create_params)
    return error_400(officer.errors) unless officer.perform

    @cart_item = officer.cart_item
  end

  private

  def create_params
    # TODO: REPLACE User.first.id with params, for testing purpose only
    params[:user_id] = User.first.id.to_s

    params.permit(:product_variant_id, :quantity, :user_id)
  end
end
