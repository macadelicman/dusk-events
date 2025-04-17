class CreateCountries < ActiveRecord::Migration[8.0]
  def change
    create_table :countries, id: :uuid do |t|
      t.string :name
      t.string :code
      t.string :flag_url

      t.timestamps
    end
    add_index :countries, :name
    add_index :countries, :code, unique: true
  end
end
