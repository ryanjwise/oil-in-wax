class Address < ApplicationRecord
  belongs_to :user

  # Ensure fields are populated when sign-up form is filled.
  validates :street_num, presence: true
  validates :street,     presence: true
  validates :city,       presence: true
  validates :state,      presence: true
  validates :post_code,  presence: true

  # Validate length of postcode
  validates :post_code, length: { is: 4 }
end
