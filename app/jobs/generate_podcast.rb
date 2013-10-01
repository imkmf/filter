module GeneratePodcast
  @queue = :filter_queue

  class << self
    def perform
      @podcasts = Podcast.all
      @subscribers = @podcasts.map { |p| p if p.user.subscribed }
      @subscribers.each do |subscriber|
        auto_update(subscriber)
      end
      @podcasts.each do |podcast|
        process_podcast(podcast)
      end
    end

    def auto_update(subscriber)
      @user = subscriber.user
      @api ||= Soundcloud::API.new(user.token)
      @soundcloud_episodes = @api.user_tracks(user.uid,
                                              limit: user.limit,
                                              filter: 'downloadable')
      @soundcloud_episodes.each do |episode|
        unless Episode.find_by_sc_id(episode['id']) || @user.blacklist.include?(episode['id'])
          @sc_track = api.track(episode['id'])
          @cover = @sc_track['artwork_url']
          @link = "#{ @sc_track['download_url'] }?client_id=#{ Figaro.env.soundcloud_key }"
          @episode = @subscriber.episodes.create(
            name: @sc_track['title'],
            description: @sc_track['description'],
            cover: @cover,
            link: @link,
            sc_id: @sc_id
          )
        end
      end
    end

    def process_podcast(podcast)
      # do the stuff
      @name = podcast.name
      @description = podcast.description
      @cover = podcast.cover
      # Get language code
      # LanguageList::LanguageInfo.find("3DIGIT")
      # Category
      # Erb Escape
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
