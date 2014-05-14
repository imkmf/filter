class User < ActiveRecord::Base
  has_one :podcast
  has_one :blacklist
  has_many :episodes, through: :podcast
  attr_accessor :limit

  def to_s
    "#{ name }"
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    provider = auth_hash["provider"]
    uid = auth_hash["uid"]
    info = auth_hash["info"]
    unless user = find_by_provider_and_uid(provider, uid)
      user = User.create name: info["name"], provider: provider, uid: uid, avatar_url: info["image"], token: auth_hash["credentials"]["token"]
      blacklist = user.create_blacklist
      user.update_attribute :blacklist, blacklist
    end
    user
  end

  def limit
    if self.subscribed
      nil
    else
      5
    end
  end

  def unsubscribe!
    update(
      subscribed: false,
      trial_ends_at: nil,
      subscribed_at: nil,
      stripe_token: nil
    )
  end

  def in_trial_period?
    Time.current < self.trial_ends_at
  end
end
