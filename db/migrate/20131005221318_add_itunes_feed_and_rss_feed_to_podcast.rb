class AddItunesFeedAndRssFeedToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :itunes_feed, :string
    add_column :podcasts, :rss_feed, :string
  end
end
