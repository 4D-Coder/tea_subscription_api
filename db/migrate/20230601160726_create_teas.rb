class CreateTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :teas do |t|
      t.string :description
      t.integer :temperature
      t.integer :brew_time
      t.integer :unit_price

      t.timestamps
    end
  end
end