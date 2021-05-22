class Candle < ApplicationRecord
  belongs_to :store

  has_one_attached :picture
  has_many :candle_carts, dependent: :destroy
  has_many :carts, through: :candle_carts

  validate :acceptable_image

  def acceptable_image
    return unless picture.attached?

    unless picture.byte_size <= 1.megabyte
      errors.add(:picture, "Must be 1mb or smaller")
    end

    acceptable_types = ["image/jpeg","image/jpg","image/gif", "image/png"]
    unless acceptable_types.include?(picture.content_type)
      errors.add(:picture, "Image must be a JPEG, JPG, PNG, or GIF file")
    end
  end
end
