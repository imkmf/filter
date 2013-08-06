class Podcast < ActiveRecord::Base
  belongs_to :user
  has_many :episodes
  attr_accessor :recent
  after_initialize :set_recent
  after_initialize :set_name

  def set_recent
    self.recent ||= true
  end

  def set_name
    if user
      self.name ||= "#{ user.name }'s podcast"
    else
      self.name ||= "Podcast"
    end
  end
end
