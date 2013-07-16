class AddFieldsToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :name, :string
    add_column :episodes, :cover, :string
    add_column :episodes, :link, :string
    add_column :episodes, :description, :string
  end
end
