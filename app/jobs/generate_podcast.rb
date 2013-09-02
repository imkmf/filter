module GeneratePodcast
  @queue = :filter_queue

  class << self
    def perform()
      @podcasts = Podcast.all
      @podcasts.each do |podcast|
        process_podcast(podcast)
      end
    end

    def process_podcast(podcast)
      # do the stuff
      @name = podcast.name
      @description = podcast.description
      @cover = podcast.cover
      podcast.episodes.each do |episode|
        process_episode(episode)
      end
      puts "processed #{ podcast.name }"
    end

    def process_episode(episode)
      @name = episode.name
      puts "processed #{ episode.name }"
    end
  end
end
