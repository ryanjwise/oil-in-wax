class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items
  has_many :candles, through: :order_items
  has_many :stores, through: :candles

  def order_info
    hash = {
      total_price: self.total_price,
      store_name: self.order_items.first.candle.store.name,
      created_at: self.created_at,
      receipt_url: self.receipt_url
    }
  end

end
