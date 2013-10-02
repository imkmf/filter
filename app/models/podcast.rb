class Podcast < ActiveRecord::Base
  belongs_to :user
  has_many :episodes
  after_initialize :set_name
  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories

  def set_name
    if user
      self.name ||= "#{ user.name }'s podcast"
    else
      self.name ||= "Podcast"
    end
  end
end
