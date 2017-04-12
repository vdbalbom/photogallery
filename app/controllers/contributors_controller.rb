class ContributorsController < ApplicationController

  def index
    @contributors = Contributor.all
  end

  def photos
    @Photos = Contributor.find(params[:contributor_id]).photos
  end

  def tag_photos
    @Photos = Contributor.find(params[:contributor_id]).photos & Tag.find(params[:tag_id]).photos
  end

  def new
    if admin_logged_in?
      @contributor = Contributor.new
    end
  end

  def create
    if admin_logged_in?
      @contributor = Contributor.new(new_contributor_params)
      if @contributor.save
        flash.now[:success] = "Contributor created: " + @contributor.name
        render 'new'
      else
        flash.now[:danger] = @contributor.errors.full_messages.join("<br>").html_safe
        render 'new'
      end
    end
  end

  def show
    @contributor = Contributor.find(params[:contributor_id])
  end

  def delete
    if admin_logged_in?
      @contributor = Contributor.find(params[:contributor_id])
      @contributor.photos.each do |photo|
        photo.tags.each do |tag|
          Tagger.find_by(tag_id: tag.id, photo_id: photo.id).delete
          tag.delete if tag.photos.empty?
        end
        photo.delete
      end
      @contributor.delete
      redirect_to contributors_path
    end
  end

  def settings
    if contributor_logged_in?
      @contributor = current_contributor
    end
  end

  def update_settings
    if contributor_logged_in?
      @contributor = current_contributor
      if @contributor.authenticate(contributor_params[:password])
        if @contributor.update_attributes(contributor_params)
          flash.now[:success] = 'Settings updated.'
          render 'settings'
        else
          flash.now[:danger] = @contributor.errors.full_messages.join("<br>").html_safe
          render 'settings'
        end
      else
        flash.now[:danger] = "Wrong password!"
        render 'settings'
      end
    end
  end

  def change_password
    if contributor_logged_in?
      @contributor = current_contributor
    end
  end

  def update_password
    if contributor_logged_in?
      @contributor = current_contributor
      if @contributor.update_attributes(change_password_params)
        flash.now[:success] = 'Password updated.'
        render 'change_password'
      else
        flash.now[:danger] = @contributor.errors.full_messages.join("<br>").html_safe
        render 'change_password'
      end
    end
  end

  def tags
    @contributor = Contributor.find(params[:contributor_id])
  end

  private

  def contributor_params
    params.require(:contributor).permit(:name,
                                        :profile_picture,
                                        :styles,
                                        :description,
                                        :email,
                                        :facebook_link,
                                        :instagram_link,
                                        :tumblr_link,
                                        :login,
                                        :password)
  end

  def new_contributor_params
    params.require(:contributor).permit(:name,
                                        :email,
                                        :login,
                                        :password,
                                        :password_confirmation)
  end

  def change_password_params
    params.require(:contributor).permit(:password,
                                        :password_confirmation)
  end

end
