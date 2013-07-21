module GeneratePodcast
  @queue = :filter_queue

  def self.perform()
    @podcasts = Podcast.all
    @podcasts.each do |podcast|
      puts podcast.name
    end
  end
end
