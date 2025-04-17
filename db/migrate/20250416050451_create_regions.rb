class CreateRegions < ActiveRecord::Migration[8.0]
  def change
    create_table :regions, id: :uuid do |t|
      t.string :name, null: false
      t.references :country, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :regions, [:name, :country_id], unique: true
  end
end
