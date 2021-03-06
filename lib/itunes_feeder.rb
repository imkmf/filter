require 'rss'

class ItunesFeeder
  def initialize(podcast)
    @podcast = podcast
  end

  def feed
    @_feed ||= RSS::Rss.new("2.0")
  end

  def channel
    @_channel ||= RSS::Rss::Channel.new
  end

  def podcast_information
    @podcast.categories.each do |category|
      itunes_category = RSS::ITunesChannelModel::ITunesCategory.new(category.to_it)
      channel.itunes_categories << itunes_category
    end
    channel.title = @podcast.name
    channel.description = @podcast.description
    channel.link = @podcast.website
    channel.language = @podcast.short_lang
    channel.copyright = @podcast.copyright
    channel.image = RSS::Rss::Channel::Image.new(@podcast.cover.url)
    channel.image.title = channel.title
    channel.image.url = channel.link
    channel.image.link = channel.link
    channel.itunes_author = @podcast.author
    channel.itunes_owner = RSS::ITunesChannelModel::ITunesOwner.new
    channel.itunes_owner.itunes_name = @podcast.author
    channel.itunes_owner.itunes_email = @podcast.user.email
    channel.itunes_subtitle = @podcast.subtitle
    channel.itunes_summary = @podcast.summary
    @itunes_image = RSS::ITunesChannelModel::ITunesImage.new(@podcast.cover.url)
    channel.itunes_image = @itunes_image
    channel.itunes_explicit = @podcast.explicit
    return channel
  end

  def add_episode(audio)
    @audio = audio
    @item = RSS::Rss::Channel::Item.new
    @item.title = @audio.name
    @item.link = @audio.link
    @item.guid = RSS::Rss::Channel::Item::Guid.new
    @item.guid.content = @audio.link
    @item.guid.isPermaLink = true
    @item.pubDate = @audio.updated_at.rfc2822
    @item.description = @audio.description
    @item.itunes_summary = @audio.description
    @item.itunes_subtitle = @audio.subtitle
    @item.itunes_explicit = @audio.podcast.explicit
    @item.itunes_author = @audio.podcast.author
    @duration = RSS::ITunesItemModel::ITunesDuration.new(@audio.itunes_duration)
    @item.itunes_duration = @duration

    @item.enclosure = \
      RSS::Rss::Channel::Item::Enclosure.new(@item.link, @audio.size, '@audio/mpeg')
    channel.items << @item
  end

  def save
    feed.channel = channel
    puts "Processed #{ @podcast }."
    name = "#{ @podcast.id }/#{ @podcast.id }.xml"
    xml = feed.to_s
    amazon = ToAmazon.new(xml, name)
    if amazon.save
      @podcast.update_attribute :itunes_feed, amazon.url
      puts "Saved #{ @podcast.name } XML file."
    end
  end
end
