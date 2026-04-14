require 'rails/resource_service'

require 'models/order_line'
require 'models/order'

class OrderLinePresenter
  def remove_from_cart(order_line:, order:)
    Rails::ResourceService.destroy(resource: order_line, destroy_resource_url: "/order_lines/#{order_line.id}.json") do |*args|
      order.order_lines.delete(order_line)
      $$.location.reload
    end
  end
end
  
