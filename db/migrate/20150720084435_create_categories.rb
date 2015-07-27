class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.timestamps null: false

      t.string :name, limit: 1000, null: false
      t.string :image, limit: 1000
      t.text :description

    end
  end
end
