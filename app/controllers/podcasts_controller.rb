class PodcastsController < ApplicationController
  def show
    @podcast = current_user.podcast
  end
end
