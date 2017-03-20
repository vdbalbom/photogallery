class ContributorSessionController < ApplicationController
  def new
  end

  def create
    if !contributor_logged_in? && !admin_logged_in?
      contributor = Contributor.find_by(login: params[:session][:login])
      if contributor && contributor.authenticate(params[:session][:password])
        log_in_contributor contributor
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
    log_out_contributor
    redirect_to root_url
  end
end
