class CartProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  VALID_NUMBER_REGEX = /\A[+-]?\d+\Z/

  validates :number, presence: true, format: { with: VALID_NUMBER_REGEX }
  validates :price, presence: true, format: { with: VALID_NUMBER_REGEX }

end
