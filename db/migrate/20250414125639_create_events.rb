class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events, id: :uuid do |t|
      t.string :name, null: false
      t.string :url
      t.date :date
      t.string :time
      t.string :location
      t.decimal :total_revenue, precision: 10, scale: 2
      t.decimal :total_revenue_change, precision: 5, scale: 2
      t.integer :tickets_available
      t.integer :tickets_sold
      t.decimal :tickets_sold_change, precision: 5, scale: 2
      t.integer :page_views
      t.decimal :page_views_change, precision: 5, scale: 2
      t.string :status
      t.string :img_url
      t.string :thumb_url

      t.timestamps
    end

    add_index :events, :name
    add_index :events, :date
    add_index :events, :status
    add_index :events, :page_views
    add_index :events, :thumb_url
    add_index :events, :img_url
    add_index :events, :location
  end
end
