class AddNameToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :name, :string
  end
end
