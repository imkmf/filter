class AddPodcastRefToEpisodes < ActiveRecord::Migration
  def change
    add_reference :episodes, :podcast, index: true
  end
end
