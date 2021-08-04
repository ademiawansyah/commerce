# frozen_string_literal: true

class OrderOfficer
  attr_reader :params, :user_id
  attr_reader :errors, :order

  def initialize(params)
    @params  = params
    @user_id = params[:user_id]
    @errors  = []
    @order   = nil
  end

  def perform
    unless valid?
      @errors = ['Invalid Cart Item']
      return
    end

    @order = Order.new
    order.user_id = user_id
    order.status  = :submitted
    order.save!

    cart_items.each do |cart_item|
      quantity    = cart_item.quantity
      price       = cart_item.product_variant.sell_price
      grand_total = quantity * price

      order_item                 = OrderItem.new
      order_item.order           = order
      order_item.product_variant = cart_item.product_variant
      order_item.cart_item       = cart_item
      order_item.quantity        = quantity
      order_item.price           = price
      order_item.grand_total     = grand_total
      order_item.product_detail  = {
        product_name: cart_item.product_variant.product.name,
        product_variant: cart_item.product_variant.name,
        store_name: cart_item.product_variant.product.store.name
      }.with_indifferent_access
      order_item.save!

      # update cart item already checkout
      cart_item.checkout_at = DateTime.now
      cart_item.save
    end

    order.grand_total = order.order_items.sum(&:grand_total)
    order.save!
  end

  private

  def valid?
    params[:cart_item_ids].present? && cart_items.none?(&:checkout?)
  end

  def cart_items
    @cart_items ||= CartItem.where(id: { :$in => params[:cart_item_ids] })
  end
end
