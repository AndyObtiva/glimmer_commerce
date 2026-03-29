class Order < ApplicationRecord
  has_many :order_lines
  belongs_to :shipping_address
  belongs_to :billing_address
  belongs_to :payment_info
end
