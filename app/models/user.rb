class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  has_one :store, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
end
