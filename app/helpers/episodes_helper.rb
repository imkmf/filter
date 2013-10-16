module EpisodesHelper
  def bad(episode)
    if Episode.find_by_sc_id(episode['id']) || episode['sharing'] != 'public' || episode['original_format'] != 'mp3'
      true
    end
  end
end
