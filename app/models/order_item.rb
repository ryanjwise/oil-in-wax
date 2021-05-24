class OrderItem < ApplicationRecord
  belongs_to :candle
  belongs_to :order
end
