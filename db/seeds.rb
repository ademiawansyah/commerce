# frozen_string_literal: true

3.times do
  store = Store.new
  store.name = Faker::Company.name
  store.save

  2.times do
    product = Product.new
    product.name = Faker::Commerce.product_name
    product.save

    store.products << product

    2.times do
      material = Faker::Commerce.material
      color    = Faker::Commerce.color

      variant_name = "#{material} #{color}"
      product.product_variants << ProductVariant.new(name: variant_name)
    end

  end
end
