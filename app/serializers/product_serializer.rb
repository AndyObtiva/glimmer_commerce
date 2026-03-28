class ProductSerializer < ActiveModel::Serializer
  attributes :resource_url,
             *Product.attribute_names
  
  def resource_url
    Rails.application.routes.url_helpers.product_path(object)
  end
  
  # TODO add ActiveStorage image URL in the future
end
