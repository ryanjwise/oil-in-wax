class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  has_one :address, dependent: :destroy
  has_one :store, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :address

  # scope :join_candle_store, -> { orders.includes(:order_items).includes(:candles, :stores) }
end
