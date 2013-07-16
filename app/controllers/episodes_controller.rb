class EpisodesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_podcast

  def index
    @episodes = @podcast.episodes
    @soundcloud_episodes = api.user_tracks(current_user.uid, limit: current_user.limit, filter: 'downloadable')
  end

  def new
    @sc_id = params[:sc_id]
    @sc_track = api.track(@sc_id)
    @cover ||= @sc_track['artwork_url']
    @link = "#{ @sc_track['download_url'] }?client_id=#{ Figaro.env.soundcloud_key }"
    @episode = @podcast.episodes.create(
      name: @sc_track['title'],
      description: @sc_track['description'],
      cover: @cover,
      link: @link,
      sc_id: @sc_id
    )

    if @episode
      redirect_to episodes_path, alert: "#{ @episode.name } has been added to your podcast."
    end
  end

  def destroy
    @episode = Episode.find(params[:id])
    if @episode.destroy
      redirect_to episodes_path, alert: "Episode has been deleted."
    end
  end

  private
  def get_podcast
    @podcast ||= current_user.podcast
  end
end
