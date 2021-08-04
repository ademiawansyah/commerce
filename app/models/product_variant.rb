# frozen_string_literal: true

class ProductVariant
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code, type: String
  field :name, type: String
  field :price, type: Float

  belongs_to :product
  has_many :cart_items

  before_create :generate_code

  def sell_price
    return price if price.present?

    product.price
  end

  private

  def generate_code
    string_code = name.split.map(&:first).join.upcase
    self.code = "#{product.code}-#{string_code}"
  end
end
