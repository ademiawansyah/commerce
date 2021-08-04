class CartItem
  include Mongoid::Document
  include Mongoid::Timestamps

  # field
  field :quantity, type: Integer

  # relationship
  belongs_to :cart, counter_cache: true
  belongs_to :product_variant
end
