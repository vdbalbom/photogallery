describe ContributorSessionController, type: :controller do

  before do
    @contributor = Contributor.create(name: "test123", login: "test123", password: "test123", email: "test123@sample.com")
  end

  it "create_and_destroy_session" do
    post :create, params: {session: {login: 'test123', password: 'test123'}}
    expect(current_contributor).to eq(@contributor)
    delete :destroy
    expect(current_contributor.nil?).to eq(true)
  end

end
