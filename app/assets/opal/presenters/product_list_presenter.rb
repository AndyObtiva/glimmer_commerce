require 'rails/resource_service'
require 'models/product'

class ProductListPresenter
  attr_accessor :products, :filter_product_name
  
  def initialize(products_attributes)
    self.products = products_attributes['products'].map { |product_attributes| Product.new(**product_attributes) }
    observe_filter
  end
  
  def displaying_products_text
    if filter_product_name.nil? || filter_product_name.empty?
      "Displaying all products"
    else
      "Displaying products filtered by name containing '#{filter_product_name}'"
    end
  end
  
  private
  
  def observe_filter
    @filter_observer = Glimmer::DataBinding::Observer.proc do
      fetch_products
    end
    @filter_observer.observe(self, :filter_product_name)
  end
  
  def fetch_products
    Rails::ResourceService.index(resource_class: Product,
                                 root: 'products',
                                 params: fetch_products_params) do |response, resources, metadata|
      self.products = resources
    end
  end
  
  def fetch_products_params
    params = {}
    params[:filter_product_name] = filter_product_name if filter_product_name
    params
  end
end
