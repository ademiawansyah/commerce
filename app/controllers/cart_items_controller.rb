# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :prepare_cart_item, only: [:update, :destroy]

  def create
    officer = CartItemOfficer.new(create_params)
    return error_400(officer.errors) unless officer.perform

    @cart_item = officer.cart_item
  end

  def update
    @cart_item.update!(update_params)
  end

  def destroy
    @cart_item.destroy!
  end

  private

  def create_params
    # TODO: REPLACE User.first.id with params, for testing purpose only
    params[:user_id] = User.first.id.to_s

    params.permit(:product_variant_id, :quantity, :user_id)
  end

  def update_params
    params.permit(:quantity)
  end

  def prepare_cart_item
    @cart_item = CartItem.find params[:id]
  end
end
