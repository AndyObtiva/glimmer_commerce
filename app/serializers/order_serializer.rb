class OrderSerializer < ActiveModel::Serializer
  has_many :order_lines
  attributes :id, :order_lines, :subtotal, :shipping, :sales_tax, :total
end
