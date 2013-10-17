class AddKeywordsToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :keywords, :text
  end
end
