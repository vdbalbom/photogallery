class AdminSessionController < ApplicationController
  def new
  end

  def create
    if !admin_logged_in? && !contributor_logged_in?
      admin = Admin.find_by(login: params[:session][:login])
      if admin && admin.authenticate(params[:session][:password])
        log_in_admin admin
        redirect_to root_url
      else
        flash.now[:danger] = 'Invalid login/password combination'
        render 'new'
      end
    else
      flash.now[:danger] = 'You are already logged in.'
      render 'new'
    end
  end

  def destroy
    log_out_admin
    redirect_to root_url
  end
end
