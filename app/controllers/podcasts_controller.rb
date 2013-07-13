class PodcastsController < ApplicationController
  def show
    @podcast = current_user.podcast
    @tracks = api.user_tracks(current_user.uid, limit: current_user.limit, filter: 'downloadable')
  end
end
