class PagesController < ApplicationController
  layout "front", only: [:home]
  def home
  end

  def help
  end
end
