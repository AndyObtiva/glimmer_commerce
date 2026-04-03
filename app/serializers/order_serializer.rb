class OrderSerializer < ActiveModel::Serializer
  has_many :order_lines
  belongs_to :shipping_address, serializer: AddressSerializer
  belongs_to :billing_address, serializer: AddressSerializer
  attributes :id, :shipping_address, :billing_address, :order_lines, :subtotal, :shipping, :sales_tax, :total
end
