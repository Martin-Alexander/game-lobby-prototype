class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.references :user, foreign_key: true
      t.references :game, foreign_key: true
      t.string :role
      t.boolean :host
      t.boolean :presence

      t.timestamps
    end
  end
end
