class AddColumnToMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :menus, :activated, :integer
  end
end
