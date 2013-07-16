class AddSoundcloudIdToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :sc_id, :string
  end
end
