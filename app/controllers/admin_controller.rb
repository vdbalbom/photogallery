class AdminController < ApplicationController
  def site_settings
    if admin_logged_in?
      if admin_logged_in?
        @admin = current_admin
      end
    end
  end

  def settings
    if admin_logged_in?
      @admin = current_admin
    end
  end

  def update_admin
    if admin_logged_in?
      @admin = current_admin
      if @admin.update_attributes(admin_params)
        flash.now[:success] = 'Settings updated.'
        render 'settings'
      else
        flash.now[:danger] = @admin.errors.full_messages.join("<br>").html_safe
        render 'settings'
      end
    end
  end

  def update_site
    if admin_logged_in?
      @admin = current_admin
      if @admin.authenticate(site_params[:password])
        if @admin.update_attributes(site_params)
          flash.now[:success] = 'Site settings updated.'
          render 'site_settings'
        else
          flash.now[:danger] = @admin.errors.full_messages.join("<br>").html_safe
          render 'site_settings'
        end
      else
        flash.now[:danger] = "Wrong password!"
        render 'site_settings'
      end
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:login,
                                  :password,
                                  :password_confirmation)
  end

  def site_params
    params.require(:admin).permit(:site_title,
                                  :site_description,
                                  :password)
  end
end
