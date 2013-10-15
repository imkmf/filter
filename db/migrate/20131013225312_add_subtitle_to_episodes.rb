class AddSubtitleToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :subtitle, :text
  end
end
