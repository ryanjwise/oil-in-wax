class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items
  has_many :candles, through: :order_items

end
