class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    #@podcast = @user.podcast.find_or_create
    session[:user_id] = @user.id
    current_user = @user
    redirect_to root_path
    #redirect_to my_podcast_path(podcast_id: @podcast.id)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
