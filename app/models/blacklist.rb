class Blacklist < ActiveRecord::Base
  belongs_to :user
  #before_create :wtf

  def include?(id)
    episodes.include?(id) || episodes.include?(id.to_i)
  end

  def add(id)
    self.episodes.push(id)
    self.save
  end

  def remove(id)
    episodes.delete(id)
    save
  end

  private
  def wtf
    self.episodes ||= Array.new
  end
end
