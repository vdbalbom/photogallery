module AdminSessionHelper

  def log_in_admin admin
    session[:admin_id] = admin.id
  end

  def current_admin
    Admin.find_by(id: session[:admin_id])
  end

  def admin_logged_in?
    !current_admin.nil?
  end

  def log_out_admin
    session.delete(:admin_id)
    @current_admin = nil
  end

end
