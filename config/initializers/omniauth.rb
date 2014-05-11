Rails.application.config.middleware.use OmniAuth::Builder do
  provider :soundcloud, ENV["SOUNDCLOUD_KEY"], ENV["SOUNDCLOUD_SECRET"]
end
