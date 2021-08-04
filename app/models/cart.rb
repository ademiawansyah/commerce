class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  # field
  field :checkout_at, type: DateTime

  # relationship
  belongs_to :user
  has_many   :cart_items

  def self.active
    find_by checkout_at: nil
  end
end
