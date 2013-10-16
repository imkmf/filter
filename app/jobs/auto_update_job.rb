module AutoUpdateJob
  @queue = :filter_queue

  class << self
    def perform
      @podcasts = Podcast.all
      @podcasts.each do |podcast|
        puts "Processing #{ podcast.name }."
        PodcastJobUtils.new(podcast.id).auto_update
      end
    end
  end
end
