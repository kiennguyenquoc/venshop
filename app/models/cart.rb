class Cart < ActiveRecord::Base
  has_many :cart_products, dependent: :destroy

  def add_product(product_id, price)
    current_item = cart_products.find_by(product_id: product_id)
      if current_item
        current_item.number += 1
      else
        current_item = cart_products.build(product_id: product_id, price: price)
      end
    current_item
  end

  def total_price
    cart_products.to_a.sum { |item| item.total_price }
  end
end
