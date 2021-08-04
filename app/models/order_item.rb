class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :product_detail, type: Hash
  field :quantity, type: Integer
  field :price, type: Float
  field :grand_total, type: Float

  belongs_to :product_variant
  belongs_to :order, counter_cache: true
  belongs_to :cart_item
end
