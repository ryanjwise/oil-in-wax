class Cart < ApplicationRecord

  has_one :order
  has_many :candle_carts, dependent: :destroy
  has_many :candles, through: :candle_carts
end
