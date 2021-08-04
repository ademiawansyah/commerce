class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum

  field :grand_total, type: Float

  belongs_to :user
  has_many :order_items

  enum :status, [:submitted, :cancelled]
end
