class AddIsAtToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_at, :string, default: "main_menu"
  end
end
