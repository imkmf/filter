class AddDescriptionToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :description, :string
  end
end
