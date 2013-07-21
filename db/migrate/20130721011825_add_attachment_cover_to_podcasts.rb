class AddAttachmentCoverToPodcasts < ActiveRecord::Migration
  def self.up
    change_table :podcasts do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :podcasts, :cover
  end
end
