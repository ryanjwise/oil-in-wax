class Store < ApplicationRecord
  belongs_to :user
  has_many :candles
end
