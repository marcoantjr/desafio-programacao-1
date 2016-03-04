class AddFilenameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :filename, :string,  null: false, default: ""
  end
end
