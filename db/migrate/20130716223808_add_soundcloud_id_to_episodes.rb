class AddSoundcloudIdToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :sc_id, :integer
  end
end
