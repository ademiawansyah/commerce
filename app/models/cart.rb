class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  # field

  # relationship
  belongs_to :user
  has_many   :cart_items
end
