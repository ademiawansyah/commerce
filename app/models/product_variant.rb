# frozen_string_literal: true

class ProductVariant
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code, type: String
  field :name, type: String

  embedded_in :product

  before_create :generate_code

  private

  def generate_code
    string_code = name.split.map(&:first).join.upcase
    self.code = "#{product.code}-#{string_code}"
  end
end
