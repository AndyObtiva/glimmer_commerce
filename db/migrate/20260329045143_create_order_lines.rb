class CreateOrderLines < ActiveRecord::Migration[7.2]
  def change
    create_table :order_lines do |t|
      t.integer :order_id
      t.integer :product_id
      t.string :size
      t.integer :quantity

      t.timestamps
    end
  end
end
