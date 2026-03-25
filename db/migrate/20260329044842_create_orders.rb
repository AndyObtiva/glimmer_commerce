class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.integer :shipping_address_id
      t.integer :billing_address_id
      t.integer :payment_info_id
      t.decimal :subtotal
      t.decimal :shipping
      t.decimal :sales_tax
      t.decimal :total
      t.boolean :placed

      t.timestamps
    end
  end
end
