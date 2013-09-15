module PodcastsHelper
  def podcast_plan
    if current_user.subscribed?
      "Pro Plan"
    else
      "Free Plan"
    end
  end
end
