class AddFieldsToPodcast < ActiveRecord::Migration
  def change
    add_column :podcasts, :website, :string
    add_column :podcasts, :language, :string
    add_column :podcasts, :subtitle, :string
    add_column :podcasts, :author, :string
    add_column :podcasts, :summary, :text
    add_column :podcasts, :copyright, :string
    add_column :podcasts, :explicit, :string
  end
end
