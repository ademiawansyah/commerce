# frozen_string_literal: true

class CartItemOfficer
  attr_reader :params, :errors, :cart_item

  def initialize(params)
    @params    = params
    @errors    = []
    @cart_item = nil
  end

  def perform
    unless valid?
      @errors << 'Product Variant ID or User ID is Required'
      return
    end

    quantity = params[:quantity].blank? ? 1 : params[:quantity]

    @cart_item = CartItem.find_or_initialize_by(
      cart: cart,
      product_variant: product_variant
    )

    if cart_item.new_record?
      cart_item.quantity = quantity
    else
      cart_item.quantity += quantity
    end

    cart_item.save
  end

  def valid?
    params[:product_variant_id].present? && params[:user_id].present?
  end

  def cart
    @cart ||= Cart.where(user_id: params[:user_id]).active || build_cart
  end

  def build_cart
    Cart.create!(
      checkout_at: nil,
      user_id: params[:user_id]
    )
  end

  def product_variant
    @product_variant ||= ProductVariant.find params[:product_variant_id]
  end
end
