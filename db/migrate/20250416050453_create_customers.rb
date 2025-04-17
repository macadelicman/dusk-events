class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :address
      t.references :country, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :customers, :email, unique: true
  end
end
