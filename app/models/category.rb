class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy
  default_scope -> { order(name: :asc) }
end
