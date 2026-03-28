require 'models/product'

ProductPresenter = Struct.new(:products_json, :products, keyword_init: true) do
  def initialize(**args)
    super(**args)
    initialize_products(args[:products_json])
  end
  
  private
  
  def initialize_products(products_json)
    products_array_of_hashes = JSON.parse(products_json)
    self.products = products_array_of_hashes.map {|product_hash| Product.new(**product_hash) }
  end
end
