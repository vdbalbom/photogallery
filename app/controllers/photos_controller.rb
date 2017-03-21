class PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:photo_id])
  end

  def edit
    if contributor_logged_in?
      photo = Photo.find(params[:photo_id])
      if photo.contributor_id == current_contributor.id
        @photo = photo
      end
    end
  end

  def new
    if contributor_logged_in?
      @photo = Photo.new
    end
  end

  def create
    if contributor_logged_in?
      @photo = Photo.new(photo_params)
      @photo.contributor = current_contributor
      if @photo.save
        flash.now[:success] = 'New photo uploaded.'
        render 'new'
      else
        flash.now[:danger] = @photo.errors.full_messages.join("<br>").html_safe
        render 'new'
      end
    end
  end

  def destroy
    if contributor_logged_in?
      photo = Photo.find(params[:photo_id])
      if photo.contributor_id == current_contributor.id
        photo.delete
      end
    end
  end

  def update
    if contributor_logged_in?
      photo = Photo.find(params[:photo_id])
      if photo.contributor_id == current_contributor.id
        @photo = photo
        if @photo.update_attributes(photo_params)
          flash.now[:success] = 'Settings updated.'
          render 'edit'
        else
          flash.now[:danger] = @photo.errors.full_messages.join("<br>").html_safe
          render 'edit'
        end
      end
    end
  end

  private

    def photo_params
      params.require(:photo).permit(:title,
                                    :image,
                                    :styles,
                                    :description)
    end

    def photo_tags
      params.require(:photo).permit(:tags)
    end
end
