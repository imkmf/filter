require 'rss/2.0'
require 'rss/itunes'

class ItunesFeeder
  attr_accessor :podcast
  attr_accessor :feed
  attr_accessor :channel
  def initialize(podcast)
    @podcast = podcast
    @feed = RSS::Rss.new("2.0")
  end

  def channel
    @channel
  end

  def podcast_information
    @channel = RSS::Rss.channel.new
    @podcast.categories.each do |category|
      itunes_category = RSS::ITunesChannelModel::ITunesCategory.new(category.to_it)
      @channel.itunes_categories << itunes_category
    end
    @channel.title = @podcast.name
    @channel.description = @podcast.description
    @channel.link = @podcast.website
    @channel.language = @podcast.short_lang
    @channel.copyright = @podcast.copyright
    @channel.lastBuildDate = DateTime.now
    @channel.image = RSS::Rss::Channel::Image.new
    @channel.image.title = @channel.title
    @channel.image.url = @channel.link
    @channel.itunes_author = @podcast.author
    @channel.itunes_owner = RSS::ITunesChannelModel::ITunesOwner.new
    @channel.itunes_owner.itunes_name = @podcast.author
    @channel.itunes_owner.itunes_email = @podcast.user.email
    @channel.itunes_keywords = @podcast.keywords
    @channel.itunes_subtitle = @podcast.subtitle
    @channel.itunes_summary = @podcast.summary
    @itunes_image = RSS::ITunesChannelModel::ITunesImage.new(@podcast.cover_url)
    @channel.itunes_image = @itunes_image
    @channel.itunes_explicit = @podcast.explicit
  end

  def add_episode(audio)
    @audio = audio
    @item = RSS::Rss::Channel::Item.new
    @item.title = @audio.title
    @item.link = @audio.link
    @item.itunes_keywords = @audio.keywords
    @item.guid = RSS::Rss::Channel::Item::Guid.new
    @item.guid.content = @audio.lin
    @item.guid.isPermaLink = true
    @item.pubDate = @audio.updated_at
    @item.description = @audio.description
    @item.itunes_summary = @audio.description
    @item.itunes_subtitle = @audio.subtitle
    @item.itunes_explicit = @audio.podcast.explicit
    @item.itunes_author = @audio.podcast.author
    @item.duration = @audio.duration

    @item.enclosure = \
          RSS::Rss::Channel::Item::Enclosure.new(item.link, @audio.size, '@audio/mpeg')
    channel.items << @item
  end

  def save
    @feed.channel = @channel
    return @feed.to_s
  end
end