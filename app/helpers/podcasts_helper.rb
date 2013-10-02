module PodcastsHelper
  def podcast_plan
    if current_user.subscribed?
      "Pro"
    else
      "Free"
    end
  end
end
