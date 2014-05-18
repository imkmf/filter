module AutoUpdateJob
  extend HerokuResqueAutoScale if Rails.env.production? # only extend in production
  @queue = :filter_queue

  class << self
    def perform
      @podcasts = Podcast.all
      @podcasts.each do |podcast|
        puts "Processing #{ podcast.name }."
        user = podcast.user
        if user.subscribed?
          PodcastJobUtils.new(podcast.id).auto_update
        end
      end
    end
  end
end
