class AddPodcastRefToTracks < ActiveRecord::Migration
  def change
    add_reference :tracks, :podcast, index: true
  end
end
