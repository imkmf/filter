class AddAttachmentCoverToEpisodes < ActiveRecord::Migration
  def self.up
    change_table :episodes do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :episodes, :cover
  end
end
