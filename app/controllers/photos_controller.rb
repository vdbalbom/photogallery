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
        @photo.tag_list_temp = format_tag_list_temp @photo.tag_list_temp
        flash.now[:success] = 'New photo uploaded.'
        render 'new'
      else
        flash.now[:danger] = @photo.errors.full_messages.join("<br>").html_safe
        render 'new'
      end
    end
  end

  def delete
    if contributor_logged_in?
      photo = Photo.find(params[:photo_id])
      if photo.contributor_id == current_contributor.id
        photo.delete
        redirect_to contributor_photos_path(current_contributor.id)
      end
    end
  end

  def update
    if contributor_logged_in?
      photo = Photo.find(params[:photo_id])
      if photo.contributor_id == current_contributor.id
        @photo = photo
        if @photo.update_attributes(edit_photo_params)
          @photo.tag_list_temp = format_tag_list_temp @photo.tag_list_temp
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

    def format_tag_list_temp tag_list_temp
      # squeeze(' ') removes extra spaces
      # rstrip removes space in final of the string
      # gsub(' #','#').gsub('# ','#') replaces all ' #' or '# ' for '#' in the string
      # [1..-1] discards the # in the beggining of the string
      # split('#') makes a tag array
      # uniq removes duplicated tags of the tag array
      # join(' #') transforms the array into a string separated by ' #'
      # '#' + in the beggining of the sentence puts the '#'
      #    in the beggining of the string again
      '#' + tag_list_temp.squeeze(' ').rstrip.gsub(' #', '#').gsub('# ','#')[1..-1].split('#').uniq.join(' #')
    end

    def photo_params
      params.require(:photo).permit(:title,
                                    :image,
                                    :styles,
                                    :description,
                                    :tag_list_temp)
    end

    def edit_photo_params
      params.require(:photo).permit(:title,
                                    :description,
                                    :tag_list_temp)
    end
end
