class AddPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string, limit: 15
  end
end
