class OrderSerializer < ActiveModel::Serializer
  has_many :order_lines
  belongs_to :shipping_address, serializer: AddressSerializer
  belongs_to :billing_address, serializer: AddressSerializer
  belongs_to :payment_info, serializer: PaymentInfoSerializer
  attributes :id, :shipping_address, :billing_address, :payment_info, :order_lines, :subtotal, :shipping, :sales_tax, :total
  # TODO add resource_url to use in nested updates
end
