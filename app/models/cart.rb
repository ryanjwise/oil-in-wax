class Cart < ApplicationRecord
  enum status: {shopping: 1, pending: 2, complete: 3}

  belongs_to :user

  has_many :candle_carts, dependent: :destroy
  has_many :candles, through: :candle_carts
end
