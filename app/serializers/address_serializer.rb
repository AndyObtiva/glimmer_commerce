class AddressSerializer < ActiveModel::Serializer
  attributes *Address.attribute_names
end
