class PaymentInfoSerializer < ActiveModel::Serializer
  attributes *PaymentInfo.attribute_names
end
