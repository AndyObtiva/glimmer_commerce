require 'models/product'

OrderLine = Struct.new(:id, :product_id, :product, :size, :quantity, keyword_init: true) do
  def product
    the_product = self[:product]
    if the_product.is_a?(Hash)
      the_product = Product.new(the_product)
      self.product = the_product
    end
    the_product
  end
end
