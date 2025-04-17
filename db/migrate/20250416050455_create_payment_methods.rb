class CreatePaymentMethods < ActiveRecord::Migration[8.0]
  def change
    create_table :payment_methods, id: :uuid do |t|
      t.string :card_number
      t.string :card_type
      t.string :expiry
      t.references :customer, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
