require 'mechanize'
require 'rss/itunes'

class Episode < ActiveRecord::Base
  include ActiveModel::Dirty
  belongs_to :podcast
  before_save :check_302
  before_create :set_explicit

  def to_s
    name
  end

  def set_explicit
    self.explicit = self.podcast.explicit
  end

  def size
    "123456"
  end

  def check_302
    link = self.link
    if link_changed? && link.include?('download')
      agent = Mechanize.new
      new_link = agent.head(link).uri.to_s
      new_link = CGI.escapeHTML(new_link)
      self.link = new_link
    end
  end

  def itunes_duration
    seconds = duration.to_i / 1000
    time = Time.at(seconds).gmtime.strftime('%R:%S')
    RSS::ITunesItemModel::ITunesDuration.parse(time)
  end
end
