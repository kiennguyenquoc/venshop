class Product < ActiveRecord::Base
  default_scope -> { order(created_at: :desc) }

  belongs_to :category
  has_many :cart_products

  VALID_NUMBER_REGEX = /\A[+-]?\d+\Z/

  validates :category_id, presence: true
  validates :name, presence: true
  validates :image, presence: true, length: { maximum: 1000 }
  validates :description, presence: true, length: { maximum: 65535 }
  validates_numericality_of :price, presence: true, format: { with: VALID_NUMBER_REGEX }, greater_than: 0

  before_destroy :ensure_not_referenced_by_any_cart_product
  before_save :convert_data_product

  def self.search(keyword)
    Product.where("name like ?", "%#{keyword}%" )
  end

  private

  def ensure_not_referenced_by_any_cart_product
    if cart_products.empty?
      return true
    else
      errors.add(:base, 'Cart products present')
      return false
    end
  end

  def convert_data_product
    self.category_id.to_i
    self.price.to_i
  end
end
