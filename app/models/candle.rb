class Candle < ApplicationRecord
  belongs_to :store

  has_many :candle_carts
  has_many :carts, through: :candle_carts
end