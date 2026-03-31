require 'models/order_line'

class Order
  attr_reader :order_lines
  
  def initialize(order_lines:)
    @order_lines = order_lines.map {|order_line_attributes| OrderLine.new(order_line_attributes)}
  end
end
