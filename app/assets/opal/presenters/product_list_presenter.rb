require 'rails/resource_service'
require 'models/product'

class ProductListPresenter
  SORT_ATTRIBUTES = ['id', 'name', 'brand', 'gender', 'age', 'price']
  SORT_ATTRIBUTE_TO_TEXT = {'id' => 'Featured'}
  SORT_DIRECTION_TO_TEXT = {'asc' => 'Ascending', 'desc' => 'Descending'}
  
  attr_accessor :products, :filter_product_name, :sort_attribute, :sort_direction
  
  def initialize(products_attributes)
    self.products = products_attributes['products'].map { |product_attributes| Product.new(**product_attributes) }
    self.sort_attribute = products_attributes[:sort_attribute]
    self.sort_direction = products_attributes[:sort_direction]
    observe_filter_and_sort
  end
  
  def displaying_products_text
    text = ''
    if filter_product_name.nil? || filter_product_name.empty?
      text += "Displaying all products"
    else
      text += "Displaying products filtered by name containing '#{filter_product_name}'"
    end
    text += " sorted by #{sort_attribute_text(sort_attribute).downcase}, #{SORT_DIRECTION_TO_TEXT[sort_direction].downcase}."
  end
  
  def sort_attribute_text(sort_attribute)
    if SORT_ATTRIBUTE_TO_TEXT.include?(sort_attribute)
      SORT_ATTRIBUTE_TO_TEXT[sort_attribute]
    else
      sort_attribute.capitalize
    end
  end
  
  private
  
  def observe_filter_and_sort
    @filter_and_sort_observer = Glimmer::DataBinding::Observer.proc do
      fetch_products
    end
    @filter_and_sort_observer.observe(self, :filter_product_name)
    @filter_and_sort_observer.observe(self, :sort_attribute)
    @filter_and_sort_observer.observe(self, :sort_direction)
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
    params[:sort_attribute] = sort_attribute if sort_attribute
    params[:sort_direction] = sort_direction if sort_direction
    params
  end
end
