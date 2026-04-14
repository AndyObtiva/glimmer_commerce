require 'models/order_line'
require 'models/address'
require 'models/payment_info'

Order = Struct.new(:id, :order_lines, :shipping_address, :billing_address, :payment_info, :subtotal, :shipping, :sales_tax, :total, keyword_init: true) do
  def initialize(*args, **attributes, &block)
    super(*args, **attributes, &block)
    self.order_lines = attributes[:order_lines].map {|order_line_attributes| OrderLine.new(order_line_attributes)}
    shipping_address_attributes = shipping_address || {}
    shipping_address_attributes = shipping_address_attributes.merge(order: self, address_name: 'shipping')
    self.shipping_address = Address.new(shipping_address_attributes)
    billing_address_attributes = billing_address || {}
    billing_address_attributes = billing_address_attributes.merge(order: self, address_name: 'billing')
    self.billing_address = Address.new(billing_address_attributes)
    if payment_info.is_a?(PaymentInfo)
      self.payment_info = payment_info
    else
      payment_info_attributes = payment_info || {}
      payment_info_attributes = payment_info_attributes.merge(order: self)
      self.payment_info = PaymentInfo.new(payment_info_attributes)
    end
  end
end
