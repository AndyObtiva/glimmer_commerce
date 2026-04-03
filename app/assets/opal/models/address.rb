# TODO it seems we need to pass its master order as an arg to ensure submit method can generate the right REST API call
Address = Struct.new(
  :order,
  :first_name, :last_name,
  :street, :city, :state_or_province, :zip_or_postal_code,
  :country,
  :phone, :email,
  keyword_init: true
) do
  def submit
    true
  end
end
