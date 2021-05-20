class RemoveForeignKeyOrdersFromCart < ActiveRecord::Migration[6.1]
  def change
    remove_reference :carts, :order, index: true
  end
end
