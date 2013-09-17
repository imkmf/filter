class Blacklist < ActiveRecord::Base
  belongs_to :user
  #before_create :wtf

  def include?(id)
    episodes.include?(id) || episodes.include?(id.to_i)
  end

  def add(id)
    update_attribute :episodes, episodes + [ id ]
  end

  def remove(id)
    update_attribute :episodes, episodes - [ id ]
  end

  private
  def wtf
    self.episodes ||= Array.new
  end
end
