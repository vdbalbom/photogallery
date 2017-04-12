class PagesController < ApplicationController
  def home
    @photos = Photo.last(18).reverse
    @tags = Tag.last(10).reverse
    @posts = Post.last(5).reverse
  end

end
