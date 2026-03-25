class Order < ApplicationRecord
  has_many :order_lines
  belongs_to :shipping_address, class_name: 'Address', optional: true
  belongs_to :billing_address, class_name: 'Address', optional: true
  belongs_to :payment_info, optional: true
  
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :payment_info
  
  before_save :place_paid_order
  
  def update_calculations!
    calculate_subtotal
    calculate_shipping
    calculate_sales_tax
    calculate_total
    save!
  end
  
  private
  
  def calculate_subtotal
    self.subtotal = order_lines.sum(&:subtotal)
  end
  
  def calculate_shipping
    self.shipping = subtotal * 0.05
  end
  
  def calculate_sales_tax
    self.sales_tax = (subtotal + shipping) * 0.10
  end
  
  def calculate_total
    self.total = subtotal + shipping + sales_tax
  end
  
  def place_paid_order
    self.placed = true if payment_info&.valid?
  end
end
