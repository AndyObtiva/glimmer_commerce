class CreatePaymentInfos < ActiveRecord::Migration[7.2]
  def change
    create_table :payment_infos do |t|
      t.string :card_number
      t.string :expiry_date
      t.string :security_code

      t.timestamps
    end
  end
end
