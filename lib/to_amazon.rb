require 's3'

class ToAmazon
  attr_accessor :url

  def initialize(file, name)
    @file = file
    @name = name
  end

  def save
    amazon = S3::Service.new(access_key_id: Figaro.env.access_key_id, secret_access_key: Figaro.env.access_key_secret)
    bucket = amazon.buckets.find(Figaro.env.aws_bucket)
    new_file = bucket.objects.build(@name)
    if @file.is_a? String
      new_file.content = @file
    else
      new_file.content = (File.read @file)
    end
    if new_file.save
      self.url = new_file.url
    end
  end
end
