class PagesController < ApplicationController
  layout false, only: [:front]
  skip_after_filter :intercom_rails_auto_include, only: [:front]
  def front
  end

  def help
  end
end
