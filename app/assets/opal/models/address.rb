require 'rails/resource_service'

Address = Struct.new(
  :id, :order,
  :address_name,
  :first_name, :last_name,
  :street, :city, :state_or_province, :zip_or_postal_code,
  :country,
  :phone, :email,
  :created_at, :updated_at,
  keyword_init: true
) do
  def address_attributes
    to_h.except(:id, :order, :address_name, :created_at, :updated_at)
  end

  def blank?
    address_attributes.values.uniq == [nil]
  end
  
  def submit(&submit_result_processor)
    address_attributes_param_name = "#{address_name}_address_attributes"
    params = { "order" => { address_attributes_param_name => address_attributes.merge(id:) } }
    update_resource_url = "/orders/#{order.id}"
    Rails::ResourceService.update(update_resource_url:, params:) do |response|
      success = response.ok?
      submit_result_processor.call(success)
    end
  end
end
