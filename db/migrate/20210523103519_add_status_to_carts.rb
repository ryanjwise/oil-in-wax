class AddStatusToCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :status, :integer
  end
end
