module AuthenticationHelper
  def contributor_sign_in login, password
    allow(controller).to receive(:current_admin).and_return(nil)
    contributor = Contributor.create!(name: login, login: login, password: password, email: "#{login}@example.com")
    allow(controller).to receive(:current_contributor).and_return(contributor)
  end

  def admin_sign_in login, password
    allow(controller).to receive(:current_contributor).and_return(nil)
    admin = Admin.create!(login: login, password: password, site_title: "Title", site_description: "")
    allow(controller).to receive(:current_admin).and_return(admin)
  end

  def sign_out
    allow(controller).to receive(:current_contributor).and_return(nil)
    allow(controller).to receive(:current_admin).and_return(nil)
  end

end

RSpec.configure do |config|
  config.include AuthenticationHelper, type: :controller
end
