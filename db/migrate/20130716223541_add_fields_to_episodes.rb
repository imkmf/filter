class AddFieldsToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :name, :text
    add_column :episodes, :cover, :string
    add_column :episodes, :link, :text
    add_column :episodes, :description, :text
  end
end
