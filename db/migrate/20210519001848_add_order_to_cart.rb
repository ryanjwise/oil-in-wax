class AddOrderToCart < ActiveRecord::Migration[6.1]
  def change
    add_reference :carts, :order, null: false, foreign_key: true
  end
end
