class User < ActiveRecord::Base
  has_one :podcast
  has_one :blacklist
  has_many :episodes, through: :podcast
  attr_accessor :limit
  after_create :new_user
  after_save :becomes_subscribed

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
      user
    else
      user
    end
  end

  def limit
    if self.subscribed
      nil
    else
      5
    end
  end

  def in_trial_period?
    Time.current < self.trial_ends_at
  end

  def new_user
    Librato.increment "user_signups"
  end

  def becomes_subscribed
    if self.subscribed && self.subscribed_changed?
      Librato.increment "user_subscription"
    end
  end
end
