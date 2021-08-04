# frozen_string_literal: true

20.times do
  store = Store.new
  store.name = Faker::Company.name
  store.save!

  10.times do
    product       = Product.new
    product.name  = Faker::Commerce.product_name
    product.store = store
    product.save!

    5.times do
      material = Faker::Commerce.material
      color    = Faker::Commerce.color

      variant_name = "#{material} #{color}"
      ProductVariant.create!(name: variant_name, product: product)
    end

  end
end

user      = User.new
user.name = Faker::Name.name
user.save!

cart             = Cart.new
cart.user        = user
cart.checkout_at = nil
cart.save!

4.times do
  store = Store.all.sample

  2.times do
    product = store.products.sample

    2.times do
      product_variant = product.product_variants.sample

      cart_item                 = CartItem.new
      cart_item.cart            = cart
      cart_item.product_variant = product_variant
      cart_item.quantity        = Faker::Number.between(from: 1, to: 10)
      cart_item.save!
    end
  end

end
