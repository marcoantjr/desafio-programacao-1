class AddFilenameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :filename, :string
  end
end
