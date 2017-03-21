class GalleryController < ApplicationController
  def all_photos
    @photos = Photo.all
  end

  def contributor_photos
    @photos = Contributor.find(params[:contributor_id]).photos
  end

  def tag_photos
    @photos = Tag.find(params[:tag_id]).photos
  end

  def contributor_tag_photos
    @photos = Contributor.find(params[:contributor_id]).photos & Tag.find(params[:tag_id]).photos
  end
end
