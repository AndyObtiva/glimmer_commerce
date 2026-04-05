# TODO we could delete this if it just pulls in basic attributes
class AddressSerializer < ActiveModel::Serializer
  attributes *Address.attribute_names
end
