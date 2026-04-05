# TODO we could delete this if it just pulls in basic attributes
class PaymentInfoSerializer < ActiveModel::Serializer
  attributes *PaymentInfo.attribute_names
end
