class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :avatar_url, :string
  end
end
