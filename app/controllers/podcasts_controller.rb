class PodcastsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user
  before_filter :get_podcast

  def show
    @episodes = @podcast.episodes
  end

  def edit; end

  private
  def get_user
    @user = current_user
  end

  def get_podcast
    @podcast = @user.podcast
  end
end
