module ApplicationHelper
  def site_title
    Admin.first.site_title
  end

  def site_description
    Admin.first.site_description
  end

  def all_contributors
    Contributor.all
  end
end
