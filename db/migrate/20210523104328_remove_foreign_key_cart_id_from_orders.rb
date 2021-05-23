class RemoveForeignKeyCartIdFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :cart, index: true
  end
end
