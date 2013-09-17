class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.integer :user_id
      t.string :episodes, array: true, default: "{}"

      t.timestamps
    end
  end
end
