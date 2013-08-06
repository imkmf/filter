class Podcast < ActiveRecord::Base
  belongs_to :user
  has_many :episodes
  after_initialize :set_name

  def set_name
    if user
      self.name ||= "#{ user.name }'s podcast"
    else
      self.name ||= "Podcast"
    end
  end
end
