class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true, foreign_key: true
      t.references :purchaser, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.references :merchant, index: true, foreign_key: true
      t.integer :quantity
      t.decimal :price, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
