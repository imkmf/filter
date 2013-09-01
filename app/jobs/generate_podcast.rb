module GeneratePodcast
  @queue = :filter_queue

  def self.perform()
    @podcasts = Podcast.all
    @podcasts.each do |podcast|
      process_podcast(podcast)
    end
  end

  def process_podcast(podcast)
    # do the stuff
    name = podcast.name
    description = podcast.description
    cover = podcast.cover
    podcast.episodes.each do |episode|
      process_episode(episode)
    end
    puts "processed #{ podcast.name }"
  end

  def process_episode(episode)
    name = episode.name
    description = episode.description
    cover = episode.cover
    link = episode.link
    sc_id = episode.sc_id
    puts "processed #{ episode.name }"
  end
end
