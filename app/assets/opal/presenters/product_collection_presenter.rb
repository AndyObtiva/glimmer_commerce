require 'glimmer/data_binding/observer'
require 'models/product'

class ProductCollectionPresenter
  attr_accessor :products, :per_page, :page, :page_count, :filter_product_name
  
  def initialize(products_attributes:, per_page:, page:, page_count:, filter_product_name:)
    # TODO should we rely on a Struct instead?
    @products = products_attributes.map {|product_hash| Product.new(**product_hash) }
    @per_page = per_page
    @page = page
    @page_count = page_count
    @filter_product_name = filter_product_name
    # TODO read page attributes from products serialized data
    observe_filter_product_name
  end
  
  def pages
    (1..page_count).to_a.map(&:to_s)
  end
    
  private
  
  def observe_filter_product_name
    filter_product_name_observer = Glimmer::DataBinding::Observer.proc do |filter_product_name_value|
      # TODO filter by JSON requests instead of document location rewriting
      location = $$.document.location.href
      new_location = !location.include?('?') ? "#{location}?filter_product_name=#{filter_product_name_value}" : "#{location}&filter_product_name=#{filter_product_name_value}"
      $$.document.location = new_location
    end
    filter_product_name_observer.observe(self, :filter_product_name)
  end
end
