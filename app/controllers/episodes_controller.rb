class EpisodesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_podcast
  before_filter :get_episode

  def index
    cookies['not_new'] = ''
    @episodes = @podcast.episodes
    @soundcloud_episodes = api.user_tracks(current_user.uid, limit: current_user.limit, filter: 'downloadable')
  end

  def create
    @sc_id = params[:sc_id]
    @sc_track = api.track(@sc_id)
    @cover ||= @sc_track['artwork_url']
    @link = "#{ @sc_track['download_url'] }?client_id=#{ ENV["SOUNDCLOUD_KEY"] }&oauth_token=#{ @podcast.user.token }"
    @episode = @podcast.episodes.build(
      name: @sc_track['title'],
      description: @sc_track['description'],
      cover: @cover,
      link: @link,
      sc_id: @sc_id,
      duration: @sc_track['duration'],
      keywords: @sc_track["tag_list"],
    )

    if @episode.save
      redirect_to episodes_path, notice: "#{ @episode.name } has been added to your podcast."
    end
  end

  def sort
    @episode = Episode.find(params[:id])
    render nothing: true if @episode.update(episode_params)
    puts @episode.row_order_position
  end

  def edit
    cookies['not_new'] = ''
  end

  def update
    if @episode.update(episode_params)
      redirect_to episodes_path, notice: "#{ @episode.name } has been updated."
    end
  end

  def destroy
    if @episode.destroy
      redirect_to episodes_path, alert: "Episode has been deleted."
    end
  end

  def blacklist
    @id = params[:sc_id]
    if current_user.blacklist.include?(@id)
      current_user.blacklist.remove(@id)
      redirect_to episodes_path, notice: "Episode will be added in auto-updates."
    else
      current_user.blacklist.add(@id)
      redirect_to episodes_path, notice: "Episode will not be added in auto-updates."
    end
  end

  private
  def episode_params
    params.require(:episode).permit(:name, :description, :link, :subtitle, :explicit, :keywords, :row_order_position)
  end

  def get_podcast
    @podcast ||= current_user.podcast
  end

  def get_episode
    @episode = Episode.find(params[:id]) if params[:id]
  end
end
