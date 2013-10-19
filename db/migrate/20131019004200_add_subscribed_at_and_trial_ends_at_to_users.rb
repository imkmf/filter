class AddSubscribedAtAndTrialEndsAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribed_at, :datetime
    add_column :users, :trial_ends_at, :datetime
  end
end
