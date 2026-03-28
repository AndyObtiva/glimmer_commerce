require 'models/product'

ProductPresenter = Struct.new(:product_attributes, :product, keyword_init: true) do
  def initialize(**args)
    super(**args)
    initialize_product(args[:product_attributes])
  end
  
  private
  
  def initialize_product(product_attributes)
    self.product = Product.new(**product_attributes)
  end
end
