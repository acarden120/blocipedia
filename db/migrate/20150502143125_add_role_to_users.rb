class AddRoleToUsers < ActiveRecord::Migration
  def change
    modify_column :users, :role, :string
  end
end
