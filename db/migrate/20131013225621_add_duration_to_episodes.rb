class AddDurationToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :duration, :string
  end
end
