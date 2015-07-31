class Product < ActiveRecord::Base

  default_scope -> { order(created_at: :desc) }

  belongs_to :category
  has_many :cart_products
  before_destroy :ensure_not_referenced_by_any_cart_product

  validates :category_id, presence: true
  validates :image, presence: true, length: { maximum: 1000 }
  validates :description, presence: true, length: { maximum: 65535 }


  private

  def ensure_not_referenced_by_any_cart_product
    if cart_products.empty?
      return true
    else
      errors.add(:base, 'Cart products present')
      return false
    end
  end
end
