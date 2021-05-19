class Cart < ApplicationRecord
  belongs_to :order

  has_many :candle_carts, dependent: :destroy
  has_many :candles, through: :candle_carts
end
