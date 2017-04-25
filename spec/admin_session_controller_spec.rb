describe AdminSessionController, type: :controller do

  before do
    @admin = Admin.create(login: "admin123", password: "admin123",
                          site_title: "Title Test",
                          site_description: "Description Test")
  end

  it "create_and_destroy_session" do
    post :create, params: {session: {login: 'admin123', password: 'admin123'}}
    expect(current_admin).to eq(@admin)
    delete :destroy
    expect(current_admin).to eq(nil)
  end

end
