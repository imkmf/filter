require 'open-uri'
require 'mechanize'

class DownloadEpisodes
  def initialize(episode)
    @episode = episode
  end

  def download
    if @episode.needs_download
      @api = Soundcloud::API.new(@episode.podcast.user.token)
      link = @api.track(@episode.sc_id)["download_url"] + "?client_id=#{ENV["SOUNDCLOUD_KEY"]}"
      agent = Mechanize.new
      new_link = agent.head(link).uri.to_s
      new_link = CGI.escapeHTML(new_link)

      name = "#{ @episode.podcast.id }/#{ @episode.s3_name }"
      download = open(new_link, "User-Agent" => "filter")
      amazon = ToAmazon.new(download, name)

      if amazon.save
        @episode.update_attribute :link, amazon.url
        @episode.update_attribute :needs_download, false

        puts "Downloaded #{ @episode.s3_name } to servers."
      end
    end
  end
end
