class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :state
      t.string :city
      t.string :street
      t.integer :street_num
      t.integer :post_code

      t.timestamps
    end
  end
end
