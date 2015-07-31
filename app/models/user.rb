class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #after_create :send_admin_mail
  attr_accessor :login
  devise :database_authenticatable,
  :registerable, :recoverable,
  :rememberable, :trackable, :validatable,
  :authentication_keys => [:login]

  VALID_PHONE_REGEX = /\d[0-9]\)*\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :phone, length: { maximum: 12 },
    format: { with: VALID_PHONE_REGEX }
  validates :username, :presence => true, length: { maximum: 50 }, :uniqueness => { :case_sensitive => false }
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  before_save   :downcase_email

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end

end