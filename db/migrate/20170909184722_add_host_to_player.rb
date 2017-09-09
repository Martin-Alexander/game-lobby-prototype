class AddHostToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :player, :host, :boolean, default: false
  end
end
