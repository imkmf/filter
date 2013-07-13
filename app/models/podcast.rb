class Podcast < ActiveRecord::Base
  belongs_to :user
  has_many :tracks
  attr_accessor :recent

  def self.find_or_create(podcast_user)
    unless podcast = where(user_id: podcast_user.id)
      podcast = Podcast.create!(user: podcast_user, recent: true)
    else
      podcast
    end
  end
end
