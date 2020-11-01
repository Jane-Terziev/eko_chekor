class UpdateUsersIndexes < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :email, :string, :null => true
    add_index :users, [:provider, :uid], unique: true
  end
end
