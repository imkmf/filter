class AddKeywordsToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :keywords, :text
  end
end
