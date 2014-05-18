module DownloadEpisodesJob
  extend HerokuResqueAutoScale if Rails.env.production? # only extend in production
  @queue = :filter_queue

  class << self
    def perform
      @episodes_to_download = Episode.where('needs_download = ?', true)
      @episodes_to_download.each do |episode|
        DownloadEpisodes.new(episode).download
      end
    end
  end
end
