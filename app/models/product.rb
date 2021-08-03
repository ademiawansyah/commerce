# frozen_string_literal: true

class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code, type: String
  field :name, type: String

  embeds_many :product_variants

  belongs_to :store

  before_create :generate_code

  private

  def generate_code
    store_code = store.name.split.map(&:first).join.upcase
    string_code = name.split.map(&:first).join.upcase
    self.code = "#{store_code}-#{string_code}"
  end
end
