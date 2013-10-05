class PagesController < ApplicationController
  layout false, only: [:front]
  def front
  end

  def help
  end
end
