class OrderSerializer < ActiveModel::Serializer
  has_many :order_lines
  attributes :order_lines, :subtotal, :shipping, :sales_tax, :total
end
