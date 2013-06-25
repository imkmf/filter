class AddUserRefToPodcast < ActiveRecord::Migration
  def change
    add_reference :podcasts, :user, index: true
  end
end
