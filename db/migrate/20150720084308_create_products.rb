class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.timestamps null: false

      t.integer :category_id
      t.string :image, limit: 1000
      t.string :name, limit: 1000, null: false
      t.decimal :price, null: false
      t.text :description
    end
    add_index :products, :category_id
  end
end
