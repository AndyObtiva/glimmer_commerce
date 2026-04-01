require 'models/order_line'

class Order
  attr_reader :id, :order_lines, :shipping_address, :subtotal, :shipping, :sales_tax, :total
  
  def initialize(id:, order_lines:, shipping_address: nil, subtotal:, shipping:, sales_tax:, total:)
    @id = id
    @order_lines = order_lines.map {|order_line_attributes| OrderLine.new(order_line_attributes)}
    @shipping_address = shipping_address # TODO instantiate Address model while passing in attributes
    @subtotal = subtotal
    @shipping = shipping
    @sales_tax = sales_tax
    @total = total
  end
end
