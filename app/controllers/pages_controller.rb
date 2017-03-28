class PagesController < ApplicationController
  def home
    @photos = Photo.last(15).reverse
    @tags = Tag.last(10).reverse
  end

  def tags
    @tags = Tag.all.reverse
  end

  def contributors
    @contributors = Contributor.all
  end
end
