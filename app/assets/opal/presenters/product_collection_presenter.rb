require 'rails/resource_service'
require 'glimmer/util/url_builder'
require 'glimmer/util/debounce'
require 'glimmer/data_binding/observer'
require 'models/product'

class ProductCollectionPresenter
  SORT_ATTRIBUTES = ['name', 'brand', 'gender', 'age', 'price']
  SORT_DIRECTIONS = {'asc' => 'Ascending', 'desc' => 'Descending'}

  attr_accessor :products, :per_page, :page, :page_count, :pages, :sort_attribute, :sort_direction,
                :filter_product_name, :filter_product_brand, :filter_product_gender, :filter_product_age
  
  def initialize(products_attributes:)
    self.products = products_attributes[:products].map {|product_hash| Product.new(product_hash) }
    self.per_page = products_attributes[:per_page]
    self.page = products_attributes[:page]
    self.page_count = products_attributes[:page_count]
    self.sort_attribute = products_attributes[:sort_attribute]
    self.sort_direction = products_attributes[:sort_direction]
    compute_pages
    self.filter_product_name = products_attributes[:filter_product_name]
    self.filter_product_brand = products_attributes[:filter_product_brand]
    self.filter_product_gender = products_attributes[:filter_product_gender]
    self.filter_product_age = products_attributes[:filter_product_age]
    observe_filter_and_sort
  end
  
  def go_to_page(page)
    self.page = page
    fetch_products
  end
  
  private
  
  def compute_pages
    self.pages = (1..page_count).to_a.map(&:to_s)
  end
  
  def observe_filter_and_sort
    return if @filter_and_sort_observer
    
    @filter_and_sort_observer = Glimmer::DataBinding::Observer.proc do
      self.page = 1
      fetch_products
    end
    @filter_and_sort_observer.observe(self, :filter_product_name)
    @filter_and_sort_observer.observe(self, :filter_product_brand)
    @filter_and_sort_observer.observe(self, :filter_product_gender)
    @filter_and_sort_observer.observe(self, :filter_product_age)
    @filter_and_sort_observer.observe(self, :sort_attribute)
    @filter_and_sort_observer.observe(self, :sort_direction)
  end
  
  def fetch_products(page: nil)
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
    params[:page] = page if page != 1
    params[:per_page] = per_page if per_page != 15
    params[:sort_attribute] = sort_attribute if sort_attribute
    params[:sort_direction] = sort_direction if sort_direction
    params[:filter_product_name] = filter_product_name if filter_product_name
    params[:filter_product_brand] = filter_product_brand if filter_product_brand
    params[:filter_product_gender] = filter_product_gender if filter_product_gender
    params[:filter_product_age] = filter_product_age if filter_product_age
    params
  end
end
