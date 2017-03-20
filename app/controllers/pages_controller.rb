class PagesController < ApplicationController
  def home
  end

  def contributors
    @contributors = Contributor.all
  end
end
