class Episode < ActiveRecord::Base
  include ActiveModel::Dirty
  belongs_to :podcast
  before_create :is_new

  def to_s
    name
  end

  def is_new
    self.needs_download = true
    self.explicit = self.podcast.explicit
    Librato.increment "episode_created"
  end

  def size
    "123456"
  end

  def check_302
  end

  def itunes_duration
    seconds = duration.to_i / 1000
    Time.at(seconds).gmtime.strftime('%R:%S')
  end

  def s3_name
    "#{ self.created_at.to_s.parameterize }-#{ self.name.parameterize }.mp3"
  end
end
