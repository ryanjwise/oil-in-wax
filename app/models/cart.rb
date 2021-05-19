class Cart < ApplicationRecord
  belongs_to :order

  has_many :candle_carts
  has_many :candles, through: :candle_carts
end
