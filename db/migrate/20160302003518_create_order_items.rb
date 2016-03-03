class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :purchaser, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.references :merchant, index: true, foreign_key: true
      t.integer :order_id, null: false
      t.integer :quantity, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
