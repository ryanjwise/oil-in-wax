class Address < ApplicationRecord
  belongs_to :user

  validates :street_num, presence: true
  validates :street,     presence: true
  validates :city,       presence: true
  validates :state,      presence: true
  validates :post_code,  presence: true
end
