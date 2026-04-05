class Order < ApplicationRecord
  has_many :order_lines
  belongs_to :shipping_address, class_name: 'Address', optional: true
  belongs_to :billing_address, class_name: 'Address', optional: true
  belongs_to :payment_info, optional: true
  
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :payment_info
  
  def update_calculations!
    calculate_subtotal
    calculate_shipping
    calculate_sales_tax
    calculate_total
    save!
  end
  
  private
  
  def calculate_subtotal
    # TODO ensure only preserving 2 decimal points
    self.subtotal = order_lines.sum(&:subtotal)
  end
  
  def calculate_shipping
    # TODO ensure only preserving 2 decimal points
    self.shipping = subtotal * 0.05
  end
  
  def calculate_sales_tax
    # TODO ensure only preserving 2 decimal points
    self.sales_tax = (subtotal + shipping) * 0.10
  end
  
  def calculate_total
    # TODO ensure only preserving 2 decimal points
    self.total = subtotal + shipping + sales_tax
  end
end
