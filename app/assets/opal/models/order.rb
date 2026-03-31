require 'models/order_line'

class Order
  attr_reader :order_lines, :subtotal, :shipping, :sales_tax, :total
  
  def initialize(order_lines:, subtotal:, shipping:, sales_tax:, total:)
    @order_lines = order_lines.map {|order_line_attributes| OrderLine.new(order_line_attributes)}
    @subtotal = subtotal
    @shipping = shipping
    @sales_tax = sales_tax
    @total = total
  end
end
