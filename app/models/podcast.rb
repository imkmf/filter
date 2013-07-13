class Podcast < ActiveRecord::Base
  belongs_to :user
  has_many :tracks
  attr_accessor :recent
  after_initialize :set_recent

  def set_recent
    self.recent ||= true
  end
end
