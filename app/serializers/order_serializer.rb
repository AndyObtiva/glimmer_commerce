class OrderSerializer < ActiveModel::Serializer
  has_many :order_lines
end
