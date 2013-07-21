class GeneratePodcast
  def initialize(podcast)
    @podcast = podcast
  end

  def populate_episodes
    @podcast.episodes.each do |episode|
      metadata(episode)
    end
  end

  def self.metadata(episode)
    "<item><title>#{ episode.name } - #{ episode.created_at }</title><link>#{ episode.link }</link><enclosure url='#{ episode.link }' length='#{ "123" }' type='audio/mpeg'></enclosure><pubDate>#{ Time.now }</pubDate><itunes:subtitle>#{ episode.name }</itunes:subtitle><itunes:summary>#{ episode.description }</itunes:summary><itunes:duration>#{ episode.length }</itunes:duration><itunes:explicit>#{ @podcast.explicit }</itunes:explicit></item>"
  end
end
