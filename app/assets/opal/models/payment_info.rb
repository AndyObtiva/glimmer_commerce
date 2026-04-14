require 'rails/resource_service'

PaymentInfo = Struct.new(
  :id, :order,
  :card_number, :expiry_date, :security_code,
  :created_at, :updated_at,
  keyword_init: true
) do
  def payment_attributes
    to_h.except(:id, :order, :created_at, :updated_at)
  end

  def blank?
    payment_attributes.values.uniq == [nil]
  end
  
  def submit(&submit_result_processor)
    params = { "order" => { "payment_info_attributes" => payment_attributes.merge(id:) } }
    update_resource_url = "/orders/#{order.id}"
    Rails::ResourceService.update(update_resource_url:, params:) do |response|
      success = response.ok?
      submit_result_processor.call(success)
    end
  end
end
