class Cart < ApplicationRecord
  enum status: {shopping: 1, pending: 2, complete: 3}
  after_initialize :set_default_status

  belongs_to :user

  has_many :candle_carts, dependent: :destroy
  has_many :candles, through: :candle_carts

  def set_default_status
    self.status ||= 1
  end
end
