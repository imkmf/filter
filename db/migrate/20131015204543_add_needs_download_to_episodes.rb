class AddNeedsDownloadToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :needs_download, :boolean
  end
end
