class AddRowOrderToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :row_order, :integer
  end
end
