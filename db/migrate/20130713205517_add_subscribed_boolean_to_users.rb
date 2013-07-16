class AddSubscribedBooleanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribed, :boolean, default: false
    User.reset_column_information
    User.all.each do |u|
      u.update_attribute :subscribed, false
    end
  end
end
