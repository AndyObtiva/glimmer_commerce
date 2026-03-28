class ProductSerializer < ActiveModel::Serializer
  attributes *Product.attribute_names
  
  # TODO add ActiveStorage image URL in the future
end
