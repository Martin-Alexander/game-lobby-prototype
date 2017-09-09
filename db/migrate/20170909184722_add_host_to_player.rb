class AddHostToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :host, :boolean, default: false
  end
end
