class Order < ApplicationRecord
  has_many :order_lines
  belongs_to :shipping_address, optional: true
  belongs_to :billing_address, optional: true
  belongs_to :payment_info, optional: true
end
