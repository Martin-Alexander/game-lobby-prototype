class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.text :data
      t.string :state

      t.timestamps
    end
  end
end
