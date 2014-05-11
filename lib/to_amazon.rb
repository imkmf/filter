require 's3'

class ToAmazon
  attr_accessor :url

  def initialize(file, name)
    @file = file
    @name = name
  end

  def save
    amazon = S3::Service.new(
      access_key_id: ENV["ACCESS_KEY_ID"],
      secret_access_key: ENV["ACCESS_KEY_SECRET"]
    )
    bucket = amazon.buckets.find(ENV["AWS_BUCKET"])
    new_file = bucket.objects.build(@name)
    if @file.is_a? String
      new_file.content = @file
    else
      new_file.content = (File.read @file)
    end
    if new_file.save
      self.url = new_file.url.gsub('files.usefilter.com.s3.amazonaws.com', 'files.usefilter.com')
    end
  end
end
