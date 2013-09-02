require 'mechanize'

class Episode < ActiveRecord::Base
  include ActiveModel::Dirty
  belongs_to :podcast
  before_save :check_302

  def check_302
    link = self.link
    if link_changed? && link.include?('stream')
      agent = Mechanize.new
      new_link = agent.head(link).uri.to_s
      self.link = new_link
    end
  end
end
