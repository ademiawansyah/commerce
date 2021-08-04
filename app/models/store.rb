# frozen_string_literal: true

class Store
  include Mongoid::Document
  include Mongoid::Timestamps

  # field
  field :name, type: String

  # relationship
  has_many :products

  # index
  index name: 'text'
end
