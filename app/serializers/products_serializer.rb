class ProductsSerializer < ActiveModel::Serializer
  OPTIONS = [:per_page, :page, :page_count,
             :filter_product_name, :filter_product_brand, :filter_product_gender, :filter_product_age,
             :sort_attribute, :sort_direction]
             
  attributes :products, *OPTIONS
  
  def products
    object.map { |product| ProductSerializer.new(product).serializable_hash }
  end
  
  OPTIONS.each do |option|
    define_method(option) do
      instance_options[option]
    end
  end
end
