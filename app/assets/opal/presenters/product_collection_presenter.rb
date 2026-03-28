require 'models/product'

class ProductCollectionPresenter
  attr_accessor :products
  
  def initialize(products_attributes)
    @products = products_attributes.map {|product_hash| Product.new(**product_hash) }
  end
end
