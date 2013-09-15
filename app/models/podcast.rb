class Podcast < ActiveRecord::Base
  belongs_to :user
  has_many :episodes
  after_initialize :set_name
  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }

  def set_name
    if user
      self.name ||= "#{ user.name }'s podcast"
    else
      self.name ||= "Podcast"
    end
  end
end
