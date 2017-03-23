class ContributorController < ApplicationController

  def new
    if admin_logged_in?
      @contributor = Contributor.new
    end
  end

  def create
    if admin_logged_in?
      hash = Contributor.last.id + 1234
      name = "contributor" + hash.to_s
      login = "contributor" + hash.to_s
      password = "password" + hash.to_s
      email = "contributor" + hash.to_s + "@example.com"
      @contributor = Contributor.create(name: name, login: login, password: password, email: email)
      flash.now[:success] = 'Contributor created. Hash is: ' + hash.to_s
      render 'new'
    end
  end

  def remove
    if admin_logged_in?
      @contributor = Contributor.find(params[:contributor_id])
    end
  end

  def delete
    if admin_logged_in?
      @contributor = Contributor.find(params[:contributor_id])
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
