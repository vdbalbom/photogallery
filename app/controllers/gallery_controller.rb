class GalleryController < ApplicationController
  def all_photos
    @tags = Tag.last(10).reverse
    @photos = Photo.all.reverse
  end

  def contributor_photos
    @contributor = Contributor.find(params[:contributor_id])
    @tags = Contributor.find(params[:contributor_id]).tags.uniq.reverse
    @photos = Contributor.find(params[:contributor_id]).photos.reverse
  end

  def tag_photos
    @tag = Tag.find(params[:tag_id])
    @photos = Tag.find(params[:tag_id]).photos.reverse
  end

  def contributor_tag_photos
    @tag = Tag.find(params[:tag_id])
    @contributor = Contributor.find(params[:contributor_id])
    @photos = (Contributor.find(params[:contributor_id]).photos & Tag.find(params[:tag_id]).photos).reverse
  end
end
