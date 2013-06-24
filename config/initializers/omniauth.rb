Rails.application.config.middleware.use OmniAuth::Builder do
  provider :soundcloud, Figaro.env.soundcloud_key, Figaro.env.soundcloud_secret
end
