class CreateCandles < ActiveRecord::Migration[6.1]
  def change
    create_table :candles do |t|
      t.references :store, null: false, foreign_key: true
      t.decimal :price
      t.integer :stock
      t.string :name
      t.text :description
      t.string :ingredients, default: [], array: true
      t.string :scents, default: [], array: true

      t.timestamps
    end
  end
end
