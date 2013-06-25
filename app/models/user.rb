class User < ActiveRecord::Base
  has_one :podcast
  has_many :tracks, through: :podcast

  def to_s
    "#{ name }"
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash["provider"]
    uid = auth_hash["uid"]
    info = auth_hash["info"]
    unless user = find_by_provider_and_uid(provider, uid)
      user = User.create name: info["name"], provider: provider, uid: uid, avatar_url: info["image"], token: auth_hash["credentials"]["token"]
    else
      user
    end
  end
end