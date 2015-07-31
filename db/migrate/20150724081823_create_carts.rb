class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.decimal :total_price, :default => 0
      t.string :status
      t.string :full_name
      t.string :phone, limit: 15
      t.string :email
      t.text :address

      t.timestamps null: false
    end
  end
end
