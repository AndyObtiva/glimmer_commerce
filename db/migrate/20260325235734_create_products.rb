class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.string :gender
      t.string :age
      t.text :description
      t.decimal :price
      t.string :image_path

      t.timestamps
    end
  end
end
