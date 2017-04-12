class TagsController < ApplicationController
  def index
    @tags = Tag.all.reverse
  end

  def photos
    @tag = Tag.find(params[:tag_id])
    @photos = @tag.photos
  end

end
