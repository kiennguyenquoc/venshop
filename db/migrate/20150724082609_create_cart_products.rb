class CreateCartProducts < ActiveRecord::Migration
  def change
    create_table :cart_products do |t|
      t.integer :cart_id, null: false
      t.integer :product_id
      t.integer :number,:default => 1
      t.integer :price

      t.timestamps null: false
    end
  end
end
