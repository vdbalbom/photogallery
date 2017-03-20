module ContributorSessionHelper

  def log_in_contributor contributor
    session[:contributor_id] = contributor.id
  end

  def current_contributor
    Contributor.find_by(id: session[:contributor_id])
  end

  def current_contributor_name
    current_contributor.name
  end

  def contributor_logged_in?
    !current_contributor.nil?
  end

  def log_out_contributor
    session.delete(:contributor_id)
    @current_contributor = nil
  end

end
