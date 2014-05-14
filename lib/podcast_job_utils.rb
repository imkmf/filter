class PodcastJobUtils
  attr_accessor :podcast
  attr_accessor :user
  attr_accessor :itunes_file
  attr_reader :api

  def initialize(id)
    @podcast = Podcast.find(id)
    @user = @podcast.user
  end

  def podcast
    @podcast
  end

  def itunes_file
    @_itunes_file ||= ItunesFeeder.new(podcast)
  end

  def api
    @_api ||= Soundcloud::API.new(@user.token)
  end

  def process_podcast
    auto_update if podcast.user.subscribed?
    itunes_file.podcast_information

    podcast.episodes.each do |episode|
      next if episode.link.include?("api.soundcloud.com/tracks")
      puts "Adding #{ episode }."
      itunes_file.add_episode(episode)
    end
    itunes_file.save
  end

  def auto_update
    puts "Auto-updating for #{ user.podcast }."
    @soundcloud_episodes = api.user_tracks(user.uid,
                                            limit: user.limit,
                                            filter: 'downloadable')
    @soundcloud_episodes.each do |episode|
      unless Episode.find_by_sc_id(episode['id']) || user.blacklist.include?(episode['id'])
        @sc_track = api.track(episode['id'])
        if @sc_track['original_format'] == 'mp3' && @sc_track['sharing'] == 'public'
          puts "Found #{ @sc_track['title'] }. Adding..."
          @cover = @sc_track['artwork_url']
          @link = "#{ @sc_track['download_url'] }?client_id=#{ ENV["SOUNDCLOUD_KEY"] }&oauth_token=#{ user.token }"
          @episode = user.podcast.episodes.create(
            name: @sc_track['title'],
            description: @sc_track['description'],
            cover: @cover,
            link: @link,
            sc_id: @sc_track['id']
          )
          puts "Auto-updated #{ @soundcloud_episodes.count } episodes."
        end
      end
    end
  end
end
