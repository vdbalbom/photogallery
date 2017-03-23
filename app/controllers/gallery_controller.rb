class GalleryController < ApplicationController
  def all_photos
    @photos = Photo.all
  end

  def contributor_photos
    @contributor = Contributor.find(params[:contributor_id])
    @photos = Contributor.find(params[:contributor_id]).photos
  end

  def tag_photos
    @tag = Tag.find(params[:tag_id])
    @photos = Tag.find(params[:tag_id]).photos
  end

  def contributor_tag_photos
    @tag = Tag.find(params[:tag_id])
    @contributor = Contributor.find(params[:contributor_id])
    @photos = Contributor.find(params[:contributor_id]).photos & Tag.find(params[:tag_id]).photos
  end
end
