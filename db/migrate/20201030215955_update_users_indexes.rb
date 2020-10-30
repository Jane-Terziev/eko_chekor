class UpdateUsersIndexes < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :email
    add_index :users, [:provider, :uid], unique: true
  end
end
