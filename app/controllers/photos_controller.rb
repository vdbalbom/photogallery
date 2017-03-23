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
      if tag_list_temp_is_valid? @photo.tag_list_temp
        if @photo.save
          @photo.tag_list_temp.update_attributes(tag_list_temp: format_tag_list_temp @photo.tag_list_temp)
          if !@photo.tag_list_temp.empty?
            add_tags @photo, @photo.tag_list_temp[1..-1].split(' #')
          end
          flash.now[:success] = 'New photo uploaded.'
          render 'new'
        else
          flash.now[:danger] = @photo.errors.full_messages.join("<br>").html_safe
          render 'new'
        end
      else
        flash.now[:danger] = "Tag list is invalid."
        render 'new'
      end
    end
  end

  def update
    if contributor_logged_in?
      photo = Photo.find(params[:photo_id])
      if photo.contributor_id == current_contributor.id
        @photo = photo
        old_tag_name_list = []
        if !@photo.tag_list_temp.empty?
          old_tag_name_list = @photo.tag_list_temp[1..-1].split(' #')
        end
        if tag_list_temp_is_valid? @photo.tag_list_temp
          if @photo.update_attributes(edit_photo_params)
            @photo.tag_list_temp.update_attributes(tag_list_temp: format_tag_list_temp @photo.tag_list_temp)
            new_tag_name_list = []
            if !@photo.tag_list_temp.empty?
              new_tag_name_list = @photo.tag_list_temp[1..-1].split(' #')
            end
            delete_tags @photo, old_tag_name_list - new_tag_name_list
            add_tags @photo, new_tag_name_list - old_tag_name_list
            flash.now[:success] = 'Settings updated.'
            render 'edit'
          else
            flash.now[:danger] = @photo.errors.full_messages.join("<br>").html_safe
            render 'edit'
          end
        else
          flash.now[:danger] = "Tag list is invalid."
          render 'edit'
        end
      end
    end
  end

  def delete
    if contributor_logged_in?
      photo = Photo.find(params[:photo_id])
      if photo.contributor_id == current_contributor.id
        if !photo.tag_list_temp.empty?
          delete_tags photo, photo.tag_list_temp[1..-1].split(' #')
        end
        photo.delete
        redirect_to contributor_photos_path(current_contributor.id)
      end
    end
    if admin_logged_in?
      photo = Photo.find(params[:photo_id])
      delete_tags photo, photo.tag_list_temp[1..-1].split(' #')
      photo.delete
      redirect_to gallery_photos_path
    end
  end

  private

    def add_tags photo, tag_name_list
      tag_name_list.each do |tag_name|
        tag = Tag.find_by(name: tag_name)
        tag = Tag.create(name: tag_name) if tag.nil?
        Tagger.create(photo_id: photo.id, tag_id: tag.id)
      end
    end

    def delete_tags photo, tag_name_list
      tag_name_list.each do |tag_name|
        tag = Tag.find_by(name: tag_name)
        Tagger.find_by(tag_id: tag.id, photo_id: photo.id).delete
        tag.delete if tag.photos.empty?
      end
    end

    def tag_list_temp_is_valid? tag_list_temp
      # removing matches the remainder needs to be empty
      tag_list_temp.gsub(/(#(\w|\s|&)*(\w|&)+(\w|\s|&)*)*/, "").empty?
    end

    def format_tag_list_temp tag_list_temp
      if tag_list_temp.remove(' ').empty?
        ''
      else
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
