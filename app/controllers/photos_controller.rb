class PhotosController < ApplicationController

  def index
    @Photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def show
    @photo = Photo.find(params[:photo_id])
  end

  def edit
    @photo = Photo.find(params[:photo_id])
  end

  def create
    if contributor_logged_in?
      @photo = Photo.new(photo_params)
      @photo.contributor = current_contributor
      @photo.tag_list_temp = format_tag_list_temp(@photo.tag_list_temp)
      if @photo.save!
        @photo.add_tags split_tags(@photo.tag_list_temp)
        @photo.save!
        flash.now[:success] = 'New photo uploaded.'
        render 'new'
      else
        flash.now[:danger] = @photo.errors.full_messages.join("<br>").html_safe
        render 'new'
      end
    end
  end

  def update
    @photo = Photo.find(params[:photo_id])
    if contributor_logged_in? && @photo.contributor == current_contributor
          @photo.assign_attributes(edit_photo_params)
          @photo.tag_list_temp = format_tag_list_temp(@photo.tag_list_temp)
          if @photo.save!
            @photo.update_tags split_tags(@photo.tag_list_temp)
            @photo.save!
            flash.now[:success] = 'Settings updated.'
            render 'edit'
          else
            flash.now[:danger] = @photo.errors.full_messages.join("<br>").html_safe
            render 'edit'
          end
      end
  end

  def delete
    if admin_logged_in? || contributor_logged_in?
      photo = Photo.find(params[:photo_id])
      if admin_logged_in? || photo.contributor == current_contributor
        photo.delete_tags
        photo.delete
        redirect_to root_path
      end
    end
  end

  private

    def split_tags tag_list_temp
      tag_list_temp.remove(' ').gsub('#',' ').lstrip.split.uniq
    end

    def format_tag_list_temp tag_list_temp
      tag_list_temp.remove(' ').split('#').uniq.join(' #').lstrip
    end

    def photo_params
      params.require(:photo).permit(:title,
                                    :image, :styles,
                                    :description,
                                    :tag_list_temp)
    end

    def edit_photo_params
      params.require(:photo).permit(:title,
                                    :description,
                                    :tag_list_temp)
    end
end
