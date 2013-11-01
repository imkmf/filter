class PodcastsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user
  before_filter :get_podcast

  def show
    @episodes = @podcast.episodes
  end

  def edit
    cookies['not_new'] = ''
  end

  def update
    if @podcast.update_attributes(podcast_params)
      redirect_to my_podcast_path, notice: "Your podcast has been updated."
    else
      redirect_to my_podcast_path, notice: "Something went wrong."
    end
  end

  def publish
    redirect_to my_podcast_path, notice: "Your podcast has been put into the publishing queue and will be published shortly."
  end

  private
  def podcast_params
    params.require(:podcast).permit(:name, :description, :cover, :subtitle, :summary, :website, :author, :copyright, :language, :explicit, :keywords, category_ids: [])
  end

  def get_user
    @user = current_user
  end

  def get_podcast
    @podcast = @user.podcast
  end
end
