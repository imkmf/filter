class AddExplicitToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :explicit, :string
  end
end
