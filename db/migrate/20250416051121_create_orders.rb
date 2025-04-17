class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :url
      t.date :order_date
      t.decimal :amount_usd, precision: 10, scale: 2
      t.decimal :amount_cad, precision: 10, scale: 2
      t.decimal :fee, precision: 10, scale: 2
      t.decimal :net_amount, precision: 10, scale: 2
      t.string :transaction_id
      t.references :payment_method, null: false, foreign_key: true, type: :uuid
      t.references :customer, null: false, foreign_key: true, type: :uuid
      t.references :event, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :orders, :transaction_id, unique: true
    add_index :orders, :order_date
  end
end
