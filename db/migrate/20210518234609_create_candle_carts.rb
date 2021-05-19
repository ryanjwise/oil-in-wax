class CreateCandleCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :candle_carts do |t|
      t.references :candle, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
