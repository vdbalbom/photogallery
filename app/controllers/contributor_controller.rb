class ContributorController < ApplicationController
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

  def change_password_params
    params.require(:contributor).permit(:password,
                                        :password_confirmation)
  end

end
