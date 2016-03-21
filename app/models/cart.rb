class Cart < ActiveRecord::Base
  has_many :cart_products, dependent: :destroy
  VALID_PHONE_REGEX = /\d[0-9]\)*\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_NUMBER_REGEX = /\A[+-]?\d+\Z/

  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }
  validates :phone, presence: true, length: { maximum: 15 },
    format: { with: VALID_PHONE_REGEX }
  validates :total_price, presence: true, format: { with: VALID_NUMBER_REGEX }
  validates :full_name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 1000 }

  before_save :downcase_email

  def add_user_id_and_status(current_user)
    current_user ? self.update(user_id: current_user.id, status: "Checkout") : self.update(user_id: "", status: "Checkout")
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
