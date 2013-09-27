class PodcastsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user
  before_filter :get_podcast

  def show
    @episodes = @podcast.episodes
  end

  def edit
  end

  def update
    if @podcast.update_attributes(podcast_params)
      redirect_to my_podcast_path, notice: "Your podcast has been updated."
    else
      redirect_to my_podcast_path, notice: "Something went wrong."
    end
  end

  private
  def podcast_params
    params.require(:podcast).permit(:name, :description, :cover, :subtitle, :summary, :website, :author, :copyright, :language, :explicit, category_ids: [])
  end

  def get_user
    @user = current_user
  end

  def get_podcast
    @podcast = @user.podcast
  end
end
