require 'models/order_line'
require 'models/address'

class Order
  attr_reader :id, :order_lines, :shipping_address, :billing_address, :subtotal, :shipping, :sales_tax, :total
  
  def initialize(id:, order_lines:, shipping_address: nil, billing_address: nil, subtotal:, shipping:, sales_tax:, total:)
    @id = id
    @order_lines = order_lines.map {|order_line_attributes| OrderLine.new(order_line_attributes)}
    shipping_address_attributes = shipping_address || {}
    shipping_address_attributes = shipping_address_attributes.merge(order: self)
    @shipping_address = Address.new(shipping_address_attributes) # TODO instantiate Address model while passing in attributes
    billing_address_attributes = billing_address || {}
    billing_address_attributes = shipping_address_attributes.merge(order: self)
    @billing_address = Address.new(billing_address_attributes) # TODO instantiate Address model while passing in attributes
    @subtotal = subtotal
    @shipping = shipping
    @sales_tax = sales_tax
    @total = total
  end
end
