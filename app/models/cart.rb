class Cart < ActiveRecord::Base
  has_many :cart_products, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }
  validates :full_name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 1000 }

  before_save :downcase_email



  def downcase_email
    self.email = email.downcase
  end

  def check_phone
    if self.phone.is_a
      return true
    else
      return false
    end
  end

end
