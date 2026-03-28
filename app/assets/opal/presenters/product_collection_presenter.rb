require 'models/product'

ProductCollectionPresenter = Struct.new(:products_attributes, :products, keyword_init: true) do
  def initialize(**args)
    super(**args)
    initialize_products(args[:products_attributes])
  end
  
  private
  
  def initialize_products(products_attributes)
    self.products = products_attributes.map {|product_hash| Product.new(**product_hash) }
  end
end
