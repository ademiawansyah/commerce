# frozen_string_literal: true

class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  # field
  field :code, type: String
  field :name, type: String
  field :price, type: Float

  # relationship
  belongs_to :store
  has_many :product_variants
  has_many :cart_items

  # callbacks
  before_create :generate_code

  # index
  index name: 'text'

  scope :by_store_name, lambda { |store_name|
    return nil if store_name.blank?

    store_ids = Store.where('$text' => { '$search' => store_name }).pluck(:id)

    where(:store_id.in => store_ids)
  }

  scope :by_product_name, lambda { |product_name|
    return nil if product_name.blank?

    where('$text' => { '$search' => product_name })
  }

  def self.search(params = {})
    by_store_name(params[:store_name])
      .by_product_name(params[:product_name])
  end

  private

  def generate_code
    store_code = store.name.split.map(&:first).join.upcase
    string_code = name.split.map(&:first).join.upcase
    self.code = "#{store_code}-#{string_code}"
  end
end
