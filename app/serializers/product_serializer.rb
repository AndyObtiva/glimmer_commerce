class ProductSerializer < ActiveModel::Serializer
  attributes :resource_path,
             *Product.attribute_names
  
  def resource_path
    Rails.application.routes.url_helpers.product_path(object)
  end
end
