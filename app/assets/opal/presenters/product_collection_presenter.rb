require 'models/product'

class ProductCollectionPresenter
  attr_accessor :products, :per_page, :page, :page_count
  
  def initialize(products_attributes:, per_page:, page:, page_count:)
    # TODO should we rely on a Struct instead?
    @products = products_attributes.map {|product_hash| Product.new(**product_hash) }
    @per_page = per_page
    @page = page
    @page_count = page_count
    # TODO read page attributes from products serialized data
  end
  
  def pages
    (1..page_count).to_a.map(&:to_s)
  end
end
