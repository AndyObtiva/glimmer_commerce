require 'rails/resource_service'
require 'models/product'

class ProductListPresenter
  SORT_ATTRIBUTES = ['id', 'name', 'brand', 'gender', 'age', 'price']
  SORT_ATTRIBUTE_TO_TEXT = {'id' => 'Featured'}
  SORT_DIRECTION_TO_TEXT = {'asc' => 'Ascending', 'desc' => 'Descending'}
  
  attr_accessor :products, :filter_product_name, :sort_attribute, :sort_direction, :per_page, :page, :page_count, :pages
  
  def initialize(products_attributes)
    self.products = products_attributes['products'].map { |product_attributes| Product.new(**product_attributes) }
    self.per_page = products_attributes[:per_page]
    self.page = products_attributes[:page]
    self.page_count = products_attributes[:page_count]
    self.sort_attribute = products_attributes[:sort_attribute]
    self.sort_direction = products_attributes[:sort_direction]
    observe_filter_and_sort
    compute_pages
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
  
  def go_to_page(page)
    self.page = page
    fetch_products
  end
  
  private
  
  def observe_filter_and_sort
    @filter_and_sort_observer = Glimmer::DataBinding::Observer.proc do
      self.page = 1
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
      self.per_page = metadata[:per_page].to_i
      self.page = metadata[:page].to_i
      self.page_count = metadata[:page_count].to_i
      compute_pages
    end
  end
  
  def fetch_products_params
    params = {}
    params[:filter_product_name] = filter_product_name if filter_product_name
    params[:sort_attribute] = sort_attribute if sort_attribute
    params[:sort_direction] = sort_direction if sort_direction
    params[:page] = page if page != 1
    params[:per_page] = per_page if per_page != 15
    params
  end
  
  def compute_pages
    self.pages = (1..page_count).to_a.map(&:to_s)
  end
end
