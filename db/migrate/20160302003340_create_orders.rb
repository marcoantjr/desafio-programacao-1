class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
