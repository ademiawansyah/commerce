# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show update destroy]

  # GET /orders
  def index
    # TODO: REPLACE User.first.id with params, for testing purpose only
    @orders = Order.where(user_id: User.first.id).all
  end

  # POST /orders
  def create
    officer = OrderOfficer.new(order_params)

    return error_400(officer.errors) unless officer.perform

    @order = officer.order
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params[:user_id] = User.first.id.to_s

    params.permit(:user_id, cart_item_ids: [])
  end
end
