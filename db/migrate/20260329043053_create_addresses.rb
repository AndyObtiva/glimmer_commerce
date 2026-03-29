class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :state_or_province
      t.string :zip_or_postal_code
      t.string :country
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
